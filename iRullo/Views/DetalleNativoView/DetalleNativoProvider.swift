//
//  DetalleNativoProvider.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 9/9/24.
//

import Foundation

// Input
protocol DetalleNativoProviderInputProtocol: BaseProviderInputProtocol {
    func uploadDataToDDBB(data: NoticiasData?)
}

final class DetalleNativoProvider: BaseProvider {
    
    weak var viewModel: DetalleNativoPresenterProtocol? {
        super.baseViewModel as? DetalleNativoPresenterProtocol
    }
    
}

extension DetalleNativoProvider: DetalleNativoProviderInputProtocol {
    
    func uploadDataToDDBB(data: NoticiasData?)   {
        let dataId = "\(data?.id ?? UUID())"
        if "\(data?.id ?? UUID())" == dataId {
            DDBB.shared.addLocal(favorite: DownloadNewModel(pId: "\(data?.id ?? UUID())",
                                                            pTypenameNoticia: data?.typenameNoticia ?? "",
                                                            pTitleNoticia: data?.titleNoticia ?? "",
                                                            pSubtitleNoticia: data?.subtitleNoticia ?? "",
                                                            pLeadingNoticia: data?.leadingNoticia ?? "",
                                                            pUrlNoticia: data?.urlNoticia ?? "",
                                                            pBodyNoticia: data?.bodyNoticia ?? "",
                                                            pShotsNoticia: DownloadShotNoticias(pIdentificadorUno: data?.shotsNoticia?.identificadorUno ?? ""))) { favoritos in
                debugPrint("favoritesData saved correctly")
            } failure: { errorData in
                debugPrint("favoritesData not saved correctly")
            }
        }
    }
}
