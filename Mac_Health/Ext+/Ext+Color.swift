//
//  Ext+Color.swift
//  Mac_Health
//
//  Created by 최진용 on 2023/10/19.
//


import SwiftUI

extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
    
    static let gray_900 = Color(hex: "0C0C0C")
    static let gray_800 = Color(hex: "1C1C1C")
    static let gray_700 = Color(hex: "242424")
    static let gray_600 = Color(hex: "343434")
    static let label_900 = Color(hex: "F5F5F5")
    static let label_800 = Color(hex: "F5F5F5").opacity(0.8)
    static let label_700 = Color(hex: "F5F5F5").opacity(0.6)
    static let label_600 = Color(hex: "F5F5F5").opacity(0.5)
    static let label_500 = Color(hex: "F5F5F5").opacity(0.4)
    static let label_400 = Color(hex: "F5F5F5").opacity(0.2)
    static let fill_1 = Color(hex: "F5F5F5").opacity(0.1)
    static let fill_2 = Color(hex: "F5F5F5").opacity(0.04)
    static let fill_3 = Color(hex: "F5F5F5").opacity(0.02)
    static let green_main = Color(hex: "2ACC7E")
    static let green_10 = Color(hex: "2ACC7E").opacity(0.1)
    static let red_main = Color(hex: "DE4744")
    static let blue_main = Color(hex: "73A3FE")
    static let purple_main = Color(hex: "AB6FF5")
    static let pink_main = Color(hex: "FE7394")
    static let yellow_main = Color(hex: "D9FA48")
    static let dim = Color(hex: "000000").opacity(0.7)
    static let tabbar_main = UIColor(Color(hex: "000000").opacity(0.75))
    static let calendar_week = UIColor(Color(hex: "F5F5F5").opacity(0.7))
    static let calendar_outdated_gray = UIColor(Color(hex: "F5F5F5").opacity(0.8))
    static let calendar_white = UIColor(Color(hex: "F5F5F5"))
}

struct Color_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 0) {
                Rectangle()
                    .foregroundColor(.gray_900)
                Divider()
                Rectangle()
                    .foregroundColor(.gray_800)
                Divider()
                Rectangle()
                    .foregroundColor(.gray_700)
                Divider()
                Rectangle()
                    .foregroundColor(.gray_600)
                Divider()
                
                Rectangle()
                    .foregroundColor(.label_900)
                Divider()
                Rectangle()
                    .foregroundColor(.label_800)
                Divider()
                Rectangle()
                    .foregroundColor(.label_700)
                Divider()
                Rectangle()
                    .foregroundColor(.label_600)
                Divider()
                Rectangle()
                    .foregroundColor(.label_500)
                Divider()
                Rectangle()
                    .foregroundColor(.label_400)
                Divider()

                Rectangle()
                    .foregroundColor(.fill_1)
                Divider()
                Rectangle()
                    .foregroundColor(.fill_2)
                Divider()
                Rectangle()
                    .foregroundColor(.fill_3)
                Divider()
                
                Rectangle()
                    .foregroundColor(.fill_1)
                Divider()
                Rectangle()
                    .foregroundColor(.fill_2)
                Divider()
                Rectangle()
                    .foregroundColor(.fill_3)
                Divider()
                
                Rectangle()
                    .foregroundColor(.green_main)
                Divider()
                Rectangle()
                    .foregroundColor(.green_10)
                Divider()
                Rectangle()
                    .foregroundColor(.red_main)
                Divider()
                Rectangle()
                    .foregroundColor(.blue_main)
                Divider()
                Rectangle()
                    .foregroundColor(.purple_main)
                Divider()
                Rectangle()
                    .foregroundColor(.pink_main)
                Divider()
                Rectangle()
                    .foregroundColor(.yellow_main)
                Divider()
                
                Rectangle()
                    .foregroundColor(.dim)
                Divider()
                Rectangle()
                    .foregroundColor(Color(uiColor: Color.tabbar_main))
                Divider()
            }
            .frame(height: 800)
        }
    }
}
