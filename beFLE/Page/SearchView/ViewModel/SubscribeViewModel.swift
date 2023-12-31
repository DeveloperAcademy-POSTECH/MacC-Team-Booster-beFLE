//
//  SubscribeViewModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/18/23.
//

import SwiftUI

class SubscribeViewModel: ObservableObject {
    @Published var influencer = ResponseGetInfluencersId(influencerName: "", routineName: "", title: "", awards: "", carouselImageUrls: [], faceImageUrl: "", introduce: "", bodySpec: BodySpec(height: 0, weight: 0), bigThree: BigThree(squat: 0, benchPress: 0, deadLift: 0), routine: PreviewExercise(date: "", part: "", exercises: []), isSubscription: false)
    //    @State var seeMore:Bool = false
    @Published var showTab = false
    @Published var scrollOffset: CGFloat = 0.00
    @Published var isSubscriptionAlertShow = false
    @Published var loggedIn = true
    
    func fetchInfluencer(influencerId: Int) {
        GeneralAPIManger.request(for: .GetInfluencersId(id: influencerId), type: ResponseGetInfluencersId.self) { result in
            switch result {
            case .success(let influencer):
                self.influencer = influencer
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func subscribeInfluecer(influencerId: Int) {
        GeneralAPIManger.request(for: .PostInfluencersSubscribe(id: influencerId), type: PostInfluencersSubscribe.self) { result in
            switch result {
            case .success(let subscription):
                self.influencer.isSubscription = subscription.isSubscription
                self.isSubscriptionAlertShow = true
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func unSubscribeInfluecer(influencerId: Int) {
        GeneralAPIManger.request(for: .PostInfluencersUnsubscribe(id: influencerId), type: PostInfluencersSubscribe.self) { result in
            switch result {
            case .success(let subscription):
                self.influencer.isSubscription = subscription.isSubscription
                self.isSubscriptionAlertShow = true
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func seperateAward(input: String) -> [String] {
        return input.components(separatedBy: ",")
    }
}
