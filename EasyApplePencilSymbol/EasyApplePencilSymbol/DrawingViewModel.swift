import SwiftUI

enum DrawingMode {
    case pen, eraser
}

class DrawingViewModel: ObservableObject {
    @Published var lines: [Line] = []
    @Published var currentLine: Line? = nil
    @Published var baseLineWidth: CGFloat = 5.0
    private var dynamicLineWidth: CGFloat = 5.0
    @Published var drawingMode: DrawingMode = .pen
    @Published var eraseCircleCenter: CGPoint = .zero
    @Published var eraseCircleRadius: CGFloat = 30.0
    
    var lineWidth: CGFloat {
        return dynamicLineWidth
    }
    
    func updateBaseLineWidth(_ width: CGFloat) {
        baseLineWidth = width
        dynamicLineWidth = width
    }
    
    func touchDown(at point: CGPoint, pressure: CGFloat) {
        if drawingMode == .pen {
            var newLine = Line()
            newLine.addPoint(point)
            newLine.lineWidth = dynamicLineWidth
            currentLine = newLine
        }
        eraseCircleCenter = point
    }
    
    
    func touchMoved(to point: CGPoint, pressure: CGFloat) {
        if drawingMode == .pen {
            currentLine?.addPoint(point)
            currentLine?.lineWidth = dynamicLineWidth
        } else if drawingMode == .eraser {
            eraseCircleCenter = point
            eraseLine(at: point)
        }
    }
    
    func touchUp() {
        if drawingMode == .pen, var currentLine = currentLine {
            currentLine.lineWidth = dynamicLineWidth
            lines.append(currentLine)
        }
        self.currentLine = nil
    }
    
    private func updateLineWidth(for pressure: CGFloat, angle: CGFloat) {
        dynamicLineWidth = min(pressure * 40, baseLineWidth * 2)
        
        let adjustedWidth = dynamicLineWidth * (1 + (angle / 90))
        dynamicLineWidth = adjustedWidth
    }
    
    func toggleDrawingMode() {
        drawingMode = (drawingMode == .pen) ? .eraser : .pen
    }
    
    func clearDrawing() {
        lines.removeAll()
    }
    
    private func eraseLine(at point: CGPoint) {
        for index in 0..<lines.count {
            var line = lines[index]
            line.points = line.points.filter { p in
                p.distance(to: point) >= eraseCircleRadius
            }
            
            if line.points.count > 1 {
                lines[index] = line
            } else {
                lines.remove(at: index)
            }
        }
    }
    
    private func lineIntersects(line1: Line, line2: Line) -> Bool {
        for point1 in line1.points {
            for point2 in line2.points {
                if point1.distance(to: point2) < max(line1.lineWidth, line2.lineWidth) {
                    return true
                }
            }
        }
        return false
    }
}

