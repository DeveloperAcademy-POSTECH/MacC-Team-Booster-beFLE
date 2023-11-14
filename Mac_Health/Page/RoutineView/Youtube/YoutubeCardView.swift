//
//  YoutubeCardView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/14/23.
//

import SwiftUI
import WebKit

struct YoutubeCardView: View {
    var body: some View {
        EmbedFrameView()
    }
}

class YoutubeModel {
    var videoID:String = ""
    var videoTitle:String = "team Booster"
}

struct EmbedView : UIViewRepresentable{
    let videoID : String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: youtubeURL))
    }

}

struct EmbedFrameView: View{
    var body: some View{
        ZStack(alignment: .center){
            HStack{
                    EmbedView(videoID: "Ian0sSuSn4I")
                        .frame(width: 268, height: 160, alignment: .center)
                        .cornerRadius(8.0)
            }
//            .frame(width: UIScreen.getWidth(268), height: UIScreen.getHeight(160))
            .overlay{
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.label_900 ,lineWidth: 2)
            }
            .background(Color.label_900)
            .cornerRadius(8)
            
//            Text(YoutubeModel().videoTitle)
//                .font(.title1())
//                .foregroundColor(.label_900)
        }
        .background(
            LinearGradient(gradient: .init(colors: [Color(hex: "F6E0BB"), Color(hex: "E5E5E5"), Color(hex: "E5E5E5")]), startPoint: .top, endPoint: .bottom)
                .cornerRadius(8.0)
        )
    }
}

#Preview {
    YoutubeCardView()
}
