//
//  FitnessExercise.swift
//  SwiftAnimation
//
//  Created by Nitin A on 18/04/19.
//  Copyright © 2019 Nitin A. All rights reserved.
//

import UIKit

class FitnessExercise {
    
    var title = ""
    var backgroundImage: UIImage
    
    init(title: String, bgImage: String) {
        self.title = title
        self.backgroundImage = UIImage(named: bgImage)!
    }
    
    static func fetchExercises() -> [FitnessExercise] {
        return [
            FitnessExercise(title: "HIIT - High intensity interval training.", bgImage: "fitness_1"),
            FitnessExercise(title: "Cardio - Lose like a winner.", bgImage: "fitness_2"),
            FitnessExercise(title: "Weigth Training.", bgImage: "fitness_3"),
            FitnessExercise(title: "Yoga", bgImage: "fitness_4"),
            FitnessExercise(title: "Zumba", bgImage: "fitness_5"),
            FitnessExercise(title: "Martial Arts", bgImage: "fitness_6")
        ]
    }
}
