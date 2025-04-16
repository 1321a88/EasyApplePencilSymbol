import SwiftUI

// 线条模型
struct Line {
    var points: [CGPoint] = []
    var lineWidth: CGFloat = 1.0
    
    mutating func addPoint(_ point: CGPoint) {
        points.append(point)
    }
}
