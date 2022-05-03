//
//  CycleModel.swift
//  CircularPath
//
//  Created by Christopher Alford on 4/11/21.
//

import Foundation
import Combine

public class CycleModel: ObservableObject {

    @Published var title: String
    @Published var timerString: String
    @Published var unit: String

    init() {
        title = "Ovulation in"
        timerString = "03"
        unit = "Days"
    }
}
