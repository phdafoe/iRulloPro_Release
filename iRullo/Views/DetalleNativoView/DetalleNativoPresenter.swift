//
//  DetalleNativoPresenter.swift
//  iRullo
//
//  Created by Andres Felipe Ocampo Eljaiek on 9/9/24.
//

import Foundation

// Output
protocol DetalleNativoPresenterProtocol: BaseProviderOutputProtocol {
//    func setFavoriteSelected(completion: Result<Bool?, NetworkError>)
}


final class DetalleNativoPresenter: BaseViewModel, ObservableObject {
    
    var provider: DetalleNativoProviderInputProtocol? {
        super.baseProvider as? DetalleNativoProviderInputProtocol
    }
    
    @Published var noticiasData: NoticiasData?
    @Published var isFavoriteSelected: Bool?
    
    
    func saveDataInDDBB() {
        self.provider?.uploadDataToDDBB(data: noticiasData)
        self.isFavoriteSelected = true
    }
    
    func isFavorito() {
        
        let dataId = "\(noticiasData?.titleNoticia ?? "")"
        
        DDBB.shared.getAllLocal { downloadNewModels in
            downloadNewModels?.downloads.map { item in
                item.map { itemX in
                    if "\(dataId)" == itemX.titleNoticia {
                        self.isFavoriteSelected = true
                    }
                }
            }
        } failure: { error in
            debugPrint(error ?? "")
        }
    }
    
    func deletefavorito() {
        let dataId = "\(noticiasData?.titleNoticia ?? "")"
        let object = DownloadNewModel(pId: "\(noticiasData?.id ?? UUID())",
                                      pTypenameNoticia: noticiasData?.typenameNoticia ?? "",
                                      pTitleNoticia: noticiasData?.titleNoticia ?? "",
                                      pSubtitleNoticia: noticiasData?.subtitleNoticia ?? "",
                                      pLeadingNoticia: noticiasData?.leadingNoticia ?? "",
                                      pUrlNoticia: noticiasData?.urlNoticia ?? "",
                                      pBodyNoticia: noticiasData?.bodyNoticia ?? "",
                                      pShotsNoticia: DownloadShotNoticias(pIdentificadorUno: noticiasData?.shotsNoticia?.identificadorUno ?? ""))
        DDBB.shared.deleteLocal(favorite: object) { array in
            array?.downloads.map { item in
                item.map { itemX in
                    if "\(dataId)" == itemX.titleNoticia {
                        debugPrint("favoritesData deleted correctly")
                        self.isFavoriteSelected = false
                    }
                }
            }
        } failure: { errorData in
            debugPrint("favoritesData not deleted correctly")
        }
    }
    
    
    
}

extension DetalleNativoPresenter: DetalleNativoPresenterProtocol {
//    func setFavoriteSelected(completion: Result<Bool?, NetworkError>) {
//        switch completion{
//        case .success(let data):
//            isFavoriteSelected = data ?? false
//        case .failure(let error):
//            debugPrint(error)
//        }
//    }
}
