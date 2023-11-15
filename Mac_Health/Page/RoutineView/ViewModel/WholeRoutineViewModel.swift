//
//  WholeRoutineViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

class WholeRoutineViewModel: ObservableObject {
    // TODO: 루틴 모델 변경
    /// 전체 루틴 목록
    @Published var routines = ResponseGetUsersInfluencersRoutines(routines: [])
    
    /// 선택된 부위
    @Published var selectedPart: WorkoutPart = .전체
    
    /// 월 별 운동 목록
    @Published var routinesByMonth: [String : [Routine]] = [:]
    
    
    /// 전체 루틴 조회 함수
    func fetchRoutines(influencerId: Int) {
        GeneralAPIManger.request(for: .GetUsersInfluencersRoutines(id: influencerId), type: [Routine].self) {
            switch $0 {
            case .success(let routine):
                self.routines.routines = routine
                self.fetchByMonth()
                print(self.routines)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// 루틴 월 별 분류 함수
    func fetchByMonth() {
        for routine in routines.routines {
            let month = routine.date.components(separatedBy: "-")[1]
            var updatedRoutine: [Routine] = []
            
            if let parsedRoutine = routinesByMonth[month] {
                updatedRoutine.append(contentsOf: parsedRoutine)
            } else {
                updatedRoutine.append(routine)
            }
            
            routinesByMonth.updateValue(updatedRoutine, forKey: month)
        }
    }
    
    /// 루틴 부위 별 분류 함수
    func fetchByPart() {
        // TODO: 부위 별 루틴 분류
    }
    
    /// 루틴 상세 정보 네비게이션 용 함수
    func viewDetailedRoutine() {
        // TODO: 선택한 루틴 상세 정보 보기
    }
}
