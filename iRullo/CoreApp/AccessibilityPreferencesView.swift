import SwiftUI

struct AccessibilityPreferencesView<Content: View>: View {
    @Environment(\.dynamicTypeSize) private var systemDynamicTypeSize
    @Environment(\.accessibilityReduceMotion) private var systemReduceMotion
    @Environment(\.colorSchemeContrast) private var systemContrast

    @AppStorage("ACCESSIBILITY_LARGER_TEXT") private var prefersLargerText = false
    @AppStorage("ACCESSIBILITY_HIGH_CONTRAST") private var prefersHighContrast = false
    @AppStorage("ACCESSIBILITY_REDUCE_MOTION") private var prefersReducedMotion = false

    private let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .dynamicTypeSize(effectiveDynamicTypeSize)
            .contrast(usesIncreasedContrast ? 1.18 : 1)
            .transaction { transaction in
                if usesReducedMotion {
                    transaction.animation = nil
                }
            }
    }

    private var effectiveDynamicTypeSize: DynamicTypeSize {
        guard prefersLargerText, !systemDynamicTypeSize.isAccessibilitySize else {
            return systemDynamicTypeSize
        }
        return .accessibility1
    }

    private var usesIncreasedContrast: Bool {
        prefersHighContrast || systemContrast == .increased
    }

    private var usesReducedMotion: Bool {
        prefersReducedMotion || systemReduceMotion
    }
}
