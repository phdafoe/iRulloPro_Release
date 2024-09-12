//
//  WalkthroughtView.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 13/8/24.
//

import SwiftUI

var totalPages = 4

struct WalkthroughtView: View {
    
    @State private var activePage: Page = .page1
    @AppStorage("currentPage") var currentPage = 1
    @State private var showLoginView: Bool = false
    
    var body: some View {
        GeometryReader {
            
            let size = $0.size
            
            VStack{
                        
                Spacer(minLength: 0)
                
                MorphingSystView(symbol: activePage.rawValue, config: .init(font: .system(size: 150, weight: .bold),
                                                                            frame: .init(width: 250, height: 200),
                                                                            radius: 30,
                                                                            foregroundColor: .white))
                
                
                
                TextContent(size: size)
                
                Spacer(minLength: 0)
                
                IndicatorView()
                
                ContinueButton()
                
            }
            .frame(maxWidth: .infinity)
            .overlay(alignment: .top) {
                HeaderView()
            }
        }
        .background {
            Rectangle()
                .fill(.black.gradient)
                .ignoresSafeArea()
        }
        
    }
    
    @ViewBuilder
    func TextContent(size: CGSize) -> some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                ForEach(Page.allCases, id: \.rawValue) { page in
                    Text(page.title)
                        .lineLimit(2)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .kerning(1.1)
                        .frame(width: size.width)
                }
            }
            .offset(x: -activePage.index * size.width)
            .animation(.smooth(duration: 0.7, extraBounce: 0.1), value: activePage)
            
            
            HStack(alignment: .top, spacing: 0) {
                ForEach(Page.allCases, id: \.rawValue) { page in
                    Text(page.subTitle)
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.gray)
                        .frame(width: size.width)
                }
            }
            .offset(x: -activePage.index * size.width)
            .animation(.smooth(duration: 0.9, extraBounce: 0.1), value: activePage)
            
        }
        .padding(.top, 15)
        .frame(width: size.width, alignment: .leading)
    }
    
    @ViewBuilder
    func IndicatorView() -> some View {
        HStack(spacing: 6) {
            ForEach(Page.allCases, id: \.rawValue) { page in
                Capsule()
                    .fill(.white.opacity(activePage == page ? 1 : 0.4))
                    .frame(width: activePage == page ? 25 : 8, height: 8)
            }
        }
        .animation(.smooth(duration: 0.5, extraBounce: 0), value: activePage)
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        HStack{
            Button{
                activePage = activePage.previusPage
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .contentShape(.rect)
            }
            .opacity(activePage != .page1 ? 1 : 0)
            
            Spacer(minLength: 0)
            
            Button("Avanzar"){
                activePage = .page4
                currentPage = 4
            }
            .fontWeight(.semibold)
            .opacity(activePage != .page4 ? 1 : 0)
        }
        .animation(.snappy(duration: 0.35, extraBounce: 0), value: activePage)
        .padding(15)
        .foregroundColor(.white)
    }
    
    
    @ViewBuilder
    func ContinueButton() -> some View {
        Button{
            activePage = activePage.nextPage
            if currentPage <= totalPages {
                currentPage += 1
            } else {
                currentPage = 1
            }
            
            if activePage == .page4 {
                showLoginView.toggle()
            }
        } label: {
            Text(activePage == .page4 ? "Bienvenidos A iRullo" : "Continuar")
                .contentTransition(.identity)
                .foregroundStyle(.black)
                .padding(.vertical, 15)
                .frame(maxWidth: activePage == .page4 ? 220 : 180)
                .background(.white, in: .capsule)
        }
        .padding(.bottom, 15)
        .animation(.smooth(duration: 0.5, extraBounce: 0), value: activePage)
        .fullScreenCover(isPresented: $showLoginView) {
            PerfilView(tipoAutentication: .signup)
        }
    }
    
}

#Preview {
    WalkthroughtView()
}
