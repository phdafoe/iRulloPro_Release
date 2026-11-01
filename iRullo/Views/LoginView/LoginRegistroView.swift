import AuthenticationServices
import SwiftUI

struct LoginRegistroView: View {
    private enum Field: Hashable {
        case email
        case password
        case confirmPassword
    }

    @EnvironmentObject private var viewModelSession: LoginRegistroPresenter
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?
    @AccessibilityFocusState private var isValidationMessageFocused: Bool
    @ScaledMetric(relativeTo: .body) private var formSpacing: CGFloat = 20
    @ScaledMetric(relativeTo: .body) private var fieldPadding: CGFloat = 16
    @ScaledMetric(relativeTo: .headline) private var appleButtonHeight: CGFloat = 50
    private let dismissOnSuccess: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var tipoAutentication: TipoAutenticacion
    @State private var validationMessage: String?

    init(tipoAutentication: TipoAutenticacion, dismissOnSuccess: Bool = true) {
        self.dismissOnSuccess = dismissOnSuccess
        _tipoAutentication = State(initialValue: tipoAutentication)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: formSpacing) {
                Text(tipoAutentication.text)
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                    .accessibilityHeading(.h1)

                TextField("Correo Electrónico", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .textContentType(.emailAddress)
                    .submitLabel(.next)
                    .focused($focusedField, equals: .email)
                    .onSubmit { focusedField = .password }
                    .accessibilityLabel("Correo electrónico")
                    .accessibilityHint("Introduce el correo asociado a tu cuenta")
                    .loginFieldStyle(padding: fieldPadding)

                SecureField("Contraseña", text: $password)
                    .textContentType(tipoAutentication == .signup ? .newPassword : .password)
                    .submitLabel(tipoAutentication == .signup ? .next : .go)
                    .focused($focusedField, equals: .password)
                    .onSubmit {
                        if tipoAutentication == .signup {
                            focusedField = .confirmPassword
                        } else {
                            authenticateWithEmail()
                        }
                    }
                    .accessibilityLabel("Contraseña")
                    .accessibilityHint(tipoAutentication == .signup
                                       ? "Crea una contraseña para tu cuenta"
                                       : "Introduce la contraseña de tu cuenta")
                    .loginFieldStyle(padding: fieldPadding)

                if tipoAutentication == .signup {
                    SecureField("Confirmar Contraseña", text: $confirmPassword)
                        .textContentType(.newPassword)
                        .submitLabel(.go)
                        .focused($focusedField, equals: .confirmPassword)
                        .onSubmit { authenticateWithEmail() }
                        .accessibilityLabel("Confirmar contraseña")
                        .accessibilityHint("Vuelve a escribir la contraseña para verificarla")
                        .loginFieldStyle(padding: fieldPadding)
                }

                if let errorMessage {
                    Label(errorMessage, systemImage: "exclamationmark.triangle.fill")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(Color(.systemRed))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel("Error: \(errorMessage)")
                        .accessibilityFocused($isValidationMessageFocused)
                }

                Button(tipoAutentication.text, action: authenticateWithEmail)
                    .buttonStyle(LoginPrimaryButtonStyle())
                    .accessibilityHint(tipoAutentication == .signup
                                       ? "Crea la cuenta con los datos introducidos"
                                       : "Inicia sesión con los datos introducidos")

                Button(tipoAutentication == .signup ? "Ya tengo una cuenta" : "Crear cuenta") {
                    validationMessage = nil
                    viewModelSession.error = nil
                    tipoAutentication = tipoAutentication == .signup ? .sigin : .signup
                    confirmPassword = ""
                }
                .buttonStyle(LoginPrimaryButtonStyle())
                .accessibilityHint(tipoAutentication == .signup
                                   ? "Cambia al formulario para iniciar sesión"
                                   : "Cambia al formulario para crear una cuenta")

                Text("Continúa con Apple")
                    .font(.title2)
                    .padding(.top, 8)
                    .accessibilityAddTraits(.isHeader)

                SignInWithAppleButton(.signIn, onRequest: configureAppleRequest, onCompletion: handleAppleCompletion)
                    .signInWithAppleButtonStyle(.whiteOutline)
                    .frame(minHeight: appleButtonHeight)
                    .padding(.horizontal, 20)
                    .accessibilityLabel("Iniciar sesión con Apple")
                    .accessibilityHint("Usa tu cuenta de Apple para continuar")
            }
            .padding()
        }
        .accentColor(.red)
        .environment(\.colorScheme, .dark)
        .onChange(of: viewModelSession.usuarioAutenticado) { _, isAuthenticated in
            if isAuthenticated && dismissOnSuccess { dismiss() }
        }
        .onChange(of: errorMessage) { _, message in
            if message != nil {
                isValidationMessageFocused = true
            }
        }
    }

    private var errorMessage: String? {
        validationMessage ?? viewModelSession.error?.localizedDescription
    }

    private func authenticateWithEmail() {
        validationMessage = nil
        viewModelSession.error = nil
        guard !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, !password.isEmpty else {
            validationMessage = "Introduce tu correo electrónico y contraseña."
            focusedField = email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .email : .password
            return
        }

        let normalizedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        switch tipoAutentication {
        case .sigin:
            viewModelSession.acceso(with: .emailAndPassword(email: normalizedEmail, password: password))
        case .signup:
            guard password == confirmPassword else {
                validationMessage = "Las contraseñas no coinciden."
                focusedField = .confirmPassword
                return
            }
            viewModelSession.registro(email: normalizedEmail, password: password, passwordConfirmation: confirmPassword)
        }
    }

    private func configureAppleRequest(_ request: ASAuthorizationAppleIDRequest) {
        let nonce = viewModelSession.randomNonceString()
        viewModelSession.currentNonce = nonce
        request.requestedScopes = [.fullName, .email]
        request.nonce = viewModelSession.sha256(nonce)
    }

    private func handleAppleCompletion(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authorization): handleAuthorization(authorization)
        case .failure(let error): validationMessage = error.localizedDescription
        }
    }

    private func handleAuthorization(_ authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let nonce = viewModelSession.currentNonce,
              let identityToken = credential.identityToken,
              let token = String(data: identityToken, encoding: .utf8) else {
            validationMessage = "No se pudo completar el inicio de sesión con Apple."
            return
        }
        viewModelSession.acceso(with: .inicioSesionConApple(idTokenString: token, nonceDes: nonce))
    }
}

private extension View {
    func loginFieldStyle(padding: CGFloat) -> some View {
        self.padding(padding)
            .foregroundStyle(.primary)
            .background(Color(.secondarySystemBackground))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(.systemGray), lineWidth: 1)
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal, 20)
    }
}

private struct LoginPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(configuration.isPressed ? Color(.systemBlue).opacity(0.8) : Color(.systemBlue))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal, 20)
    }
}

#Preview {
    LoginRegistroView(tipoAutentication: .signup)
        .environmentObject(LoginRegistroPresenter())
}
