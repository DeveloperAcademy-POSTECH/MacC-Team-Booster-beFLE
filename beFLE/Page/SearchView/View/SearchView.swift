//
//  SearchView.swift
//  beFLE
//
//  Created by 정회승 on 2023/10/20.
//

import SwiftUI

struct SearchView: View {
    @StateObject var vm = SearchViewModel()
    
    var body: some View {
        ZStack {
            switch vm.influencer.previews.count {
            case 1:
                SingleInfluencerPreviewView(influencer: $vm.influencer.previews[0])
                
            default:
                EmptyView()
            }
        }
        .onAppear {
            vm.fetchInfluencer()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
