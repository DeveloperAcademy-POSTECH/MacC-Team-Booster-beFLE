//
//  SearchViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/18/23.
//

import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var influencer = ResponseGetInfluencers(previews: [])
    
    func fetchInfluencer() {
        GeneralAPIManger.request(for: .GetInfluencers, type: ResponseGetInfluencers.self) {
            switch $0 {
            case .success(let influencer):
                // TODO: 데이터 붙이고 나서 다시 확인
                self.influencer = influencer
                print(self.influencer)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}