//
//  RecordingFinishView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/16/23.
//

import SwiftUI

struct RecordingFinishView: View {
    let routineId: Int
    @State var tabSelection: Int = 3
    @Binding var elapsedTime: TimeInterval
    @ObservedObject var recordViewModel: RecordingWorkoutViewModel
    var burnedKCalories: Int
    @StateObject var vm = RecordingFinishViewModel()
    @EnvironmentObject var editRoutineVM: EditRoutineViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            Color.gray_900.ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: UIScreen.getHeight(80))
                Image("finishIcon")
                    .frame(width: UIScreen.getWidth(276), height: UIScreen.getHeight(152))
                Image("finishInfluencer")
                    .resizable()
                    .frame(width: UIScreen.getWidth(294), height: UIScreen.getHeight(128))
                RoundedRectangle(cornerRadius: 8.0)
                    .frame(width: UIScreen.getWidth(294), height: UIScreen.getHeight(100))
                    .foregroundColor(.gray_700)
                    .overlay{
                        VStack(spacing: 5){
                            Text(vm.nowDateFormatter())
                                .font(.title1())
                                .foregroundColor(.label_900)
                            Text("오늘도 고생 많으셨어요!")
                                .font(.body())
                                .foregroundColor(.label_900)
                        }
                    }
                    .padding(.bottom, 30)
                HStack(spacing: 40){
                    VStack(spacing: 3){
                        Text(String(recordViewModel.finishTimeFormatted(elapsedTime)))
                            .font(.title2())
                            .foregroundColor(.label_900)
                        Text("운동시간")
                            .font(.body2())
                            .foregroundColor(.label_700)
                    }
                    VStack(spacing: 3){
                        Text("\(burnedKCalories)kcal")
                            .font(.title2())
                            .foregroundColor(.label_900)
                        Text("소모칼로리")
                            .font(.body2())
                            .foregroundColor(.label_700)
                    }
                    VStack(spacing: 3){
                        Text("\(vm.volume)kg")
                            .font(.title2())
                            .foregroundColor(.label_900)
                        Text("총 볼륨")
                            .font(.body2())
                            .foregroundColor(.label_700)
                    }
                }
                Spacer()
                    .frame(height: 115)
                Button{
                    tabSelection = 3
                } label: {
                    FloatingButton(backgroundColor: .green_main) { Text("기록 확인")
                            .foregroundColor(.gray_900)
                            .font(.button1())
                    }
                    .padding(.bottom, 12)
                    
                }
                
                Button{
                    dismiss()
                } label: {
                    FloatingButton(backgroundColor: .gray_600) { Text("닫기")
                            .foregroundColor(.green_main)
                            .font(.button1())
                }
                    .padding(.bottom)
                
                }
            }
        }
        .onAppear {
            vm.caculateWorkoutVolume(routineId: routineId)
        }
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }

}

//#Preview {
//    RecordingFinishView()
//}
