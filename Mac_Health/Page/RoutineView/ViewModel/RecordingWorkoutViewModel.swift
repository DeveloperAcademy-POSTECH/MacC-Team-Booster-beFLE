//
//  RecordingWorkoutViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

class RecordingWorkoutViewModel: ObservableObject {
    /// 현재 진행 중인 운동
    
    /// 현재 진행 중인 운동 시간
    @Published var workoutTime = ""
    
    /// 현재 진행 중인 운동 세트 인덱스
    @Published var currentSet = 0
    
    /// 현재 진행 중인 운동의 중단 얼럿 여부
    @Published var isStopAlertShow = false
    
    /// 현재 진행 중인 운동 일시 정지 시트 여부
    @Published var isPauseSheetShow = false
    
    /// 운동이 남아있을 때 운동 완료 얼럿 여부
    @Published var isDiscontinuewAlertShow = false
    
    /// 루틴 완료 여부
    @Published var isFinish = false
    
    //MARK: 선택한 운동: 선택한 운동 받아오기 - YONG
    @Published var selectedExercise = -1
    
    //팁 이미지 전환
    @Published var tabSelection = 0
    
    @Published var elapsedTime: TimeInterval = 0
    @Published var isRunning: Bool = false
    private var timer: Timer?
    
    
    /// 현재 진행 중인 운동 정보 조회 함수
    func fetchWorkout(routineId: Int, exerciseId: Int, completion: @escaping ((ResponseGetRoutinesExercises) -> ())) {
        GeneralAPIManger.request(for: .GetRoutinesExercises(routineId: routineId, exerciseId: exerciseId), type: ResponseGetRoutinesExercises.self) {
            switch $0 {
            case .success(let workout):
                completion(workout)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// 운동 시간 일시 정지 함수
    func pauseWorkout() {
        
    }
    
    /// 운동 팁 조회 함수
    func showTip() {
        
    }
    
    /// 운동 세트 감소 함수
    func decreaseSetCount(routineId: Int, exerciseId: Int, completion: @escaping (([ExerciseSet]) -> ())) {
        GeneralAPIManger.request(for: .DeleteRoutinesExercisesSets(routineId: routineId, exerciseId: exerciseId), type: [ExerciseSet].self) {
            switch $0 {
            case .success(let sets):
                completion(sets)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// 운동 세트 증가 함수
    func increseSetCount(routineId: Int, exerciseId: Int, completion: @escaping (([ExerciseSet]) -> ())) {
        GeneralAPIManger.request(for: .PostRoutinesExercisesSets(routineId: routineId, exerciseId: exerciseId), type: [ExerciseSet].self) {
            switch $0 {
            case .success(let sets):
                completion(sets)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// 세트 무게 또는 횟수 편집 함수
    func editSet(index: Int, routineId: Int, exerciseId: Int, setId: Int, weight: Int, reps: Int, completion: @escaping ((ResponsePatchUsersRoutinesExercisesSets) -> ())) {
        GeneralAPIManger.request(for: .PatchUsersRoutinesExercisesSets(routineId: routineId, exerciseId: exerciseId, setId: setId, weight: weight, reps: reps), type: ResponsePatchUsersRoutinesExercisesSets.self) {
            switch $0 {
            case .success(let set):
                completion(set)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// 현재 세트 완료 함수
    func finishSet(routineId: Int, exerciseId: Int, setId: Int, completion: @escaping ((ResponsePatchUsersRoutinesExercisesSetsFinish) -> ())) {
        GeneralAPIManger.request(for: .PatchUsersRoutinesExercisesSetsFinish(routineId: routineId, exerciseId: exerciseId, setId: setId), type: ResponsePatchUsersRoutinesExercisesSetsFinish.self) {
            switch $0 {
            case .success(let set):
                completion(set)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// 다음 운동 이동 네비게이션 용 함수
    func nextWorkout() {
        
    }
    
    /// 운동 완료 함수
    func finishWorkout(routineId: Int) {
        GeneralAPIManger.request(for: .PatchUsersRoutinesFinish(routineId: routineId), type: ResponsePatchUsersRoutinesFinish.self) {
            switch $0 {
            case .success:
                self.isFinish = true
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// 현재 운동 목록 네비게이션 용 함수
    func viewRoutine() {
        
    }
    
    func start() {
        isRunning = true
        
        if isRunning {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                self?.elapsedTime += 1
            }
        } else {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func stop() {
        isRunning = false
        
        if isRunning {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                self?.elapsedTime += 1
            }
        } else {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func timeFormatted() -> String {
        let hours = Int(elapsedTime) / 3600
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "%01d:%02d:%02d",hours, minutes, seconds)
    }
    
}
