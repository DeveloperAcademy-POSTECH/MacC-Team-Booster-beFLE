//
//  WorkoutView.swift
//  beFLE
//
//  Created by 송재훈 on 11/25/23.
//

import SwiftUI

enum WorkoutViewStatus {
    case emptyView
    case editRoutineView
    case recordingWorkoutView
    case recordingRoutineView
    case editRecordingRoutineView
    case recordingFinishView
}

struct WorkoutView: View {
    let routineId: Int
    
    @StateObject var vm = WorkoutViewModel()
    
    var body: some View {
        ZStack {
            switch vm.workoutViewStatus {
            case .emptyView:
                Empty
            case .editRoutineView:
                EditRoutineView()
            case .recordingWorkoutView:
                RecordingWorkoutView(routineId: routineId, exerciseId: 1, burnedKCalories: 1)
            case .recordingRoutineView:
                RecordingRoutineView(routineId: routineId, burnedKCalories: 1, recordViewModel: RecordingWorkoutViewModel())
            case .editRecordingRoutineView:
                EditRecordingRoutineView(routineId: routineId, burnedKCalories: 1)
            case .recordingFinishView:
                RecordingFinishView(routineId: routineId, elapsedTime: .constant(1), recordViewModel: RecordingWorkoutViewModel(), burnedKCalories: 1)
            }
        }
        .environmentObject(vm)
    }
}


/// 초기 뷰
extension WorkoutView {
    @ViewBuilder
    var Empty: some View {
        LottieView()
            .navigationBarBackButtonHidden()
            .onAppear {
                vm.fetchRoutineId(routineId: routineId)
                vm.changeViewStatus(.editRoutineView)
            }
    }
}

#Preview {
    WorkoutView(routineId: 1)
}