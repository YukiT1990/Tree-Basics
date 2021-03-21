//
//  Tree.swift
//  TreeBasics
//
//  Created by Yuki Tsukada on 2021/03/18.
//

import Foundation

// Who’s my parent?
func findParent() {
    print("Please input tree for findParent")
    var parents = [Int:Int]()
    var alreadyExist = [Int:Bool]()
    let preN = readLine()!.split(separator: " ").map { Int($0) }
    let n = preN[0]!
    alreadyExist[1] = true
    for i in 2...n {
        alreadyExist[i] = false
    }
    
    for _ in 0..<n-1 {
        let nodeInfo = readLine()!.split(separator: " ").map { Int($0) }
        if alreadyExist[nodeInfo[0]!] == false {
            parents[nodeInfo[0]!] = nodeInfo[1]
            alreadyExist[nodeInfo[0]!] = true
        }
        if alreadyExist[nodeInfo[1]!] == false {
            parents[nodeInfo[1]!] = nodeInfo[0]
            alreadyExist[nodeInfo[1]!] = true
        }
    }
    print("Output")
    for i in 2...n {
        print(parents[i]!)
    }
}


// Diameter
var alreadyPassed = [Int:Bool]()
var tempDistance: Int = 0
var longestDistanceValue: Int = 0

func longestDistance() {
    print("Please input tree for longestDistance")
    var distanceArray: [Dictionary<Int, Int>] = []
    var distance = [Int:Int]()
    var paths = [Int:[Dictionary<Int, Int>]]()
    
    let preN = readLine()!.split(separator: " ").map { Int($0) }
    let n = preN[0]!
    for i in 1...n {
        alreadyPassed[i] = false
    }
    for _ in 0..<n {
        let nodeInfo = readLine()!.split(separator: " ").map { Int($0) }
        var oddIndex = 1
        var evenIndex = 2
        while nodeInfo[oddIndex] != -1 {
            distance[nodeInfo[oddIndex]!] = nodeInfo[evenIndex]
            distanceArray.append(distance)
            distance.removeAll()
            oddIndex += 2
            evenIndex += 2
        }
        paths[nodeInfo[0]!] = distanceArray
        distanceArray.removeAll()
    }
    
    for i in 1...n {
        longestDistanceHelper(startPoint: i, paths: paths)
        tempDistance = 0
        for i in 1...n {
            alreadyPassed[i] = false
        }
    }
    print("Output \(longestDistanceValue)")
}


func longestDistanceHelper(startPoint: Int, paths: [Int:[Dictionary<Int, Int>]]) {
    alreadyPassed[startPoint] = true
    var nextPoints = [Int]()
    var distanceOfCurrentPath = 0
    for eachDic in paths[startPoint]! {
        nextPoints.append(eachDic.keys.first!)
    }
    if isEndPoint(intArray: nextPoints) {
        if tempDistance > longestDistanceValue {
            longestDistanceValue = tempDistance
        }
    }
    
    // iterate possible nodes from one node
    for eachDic in paths[startPoint]! {
        if !alreadyPassed[eachDic.keys.first!]! {
            // the distance of the current choice
            distanceOfCurrentPath = eachDic.values.first!
            tempDistance += distanceOfCurrentPath
            longestDistanceHelper(startPoint: eachDic.keys.first!, paths: paths)
            // before proceed to other choces, subtract the distance of the current choice
            tempDistance -= distanceOfCurrentPath
            
        }
    }
    
}

func isEndPoint(intArray: [Int]) -> Bool {
    for i in intArray {
        if alreadyPassed[i] == false {
            return false
        }
    }
    return true
}
