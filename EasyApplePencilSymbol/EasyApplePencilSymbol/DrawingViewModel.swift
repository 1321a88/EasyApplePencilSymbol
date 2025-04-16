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
    
    var lineWidth: CGFloat {
        return dynamicLineWidth
    }
    
    func updateBaseLineWidth(_ width: CGFloat) {
        baseLineWidth = width
        dynamicLineWidth = width
    }
    
    func touchDown(at point: CGPoint, pressure: CGFloat) {
        var newLine = Line()
        newLine.addPoint(point)
        newLine.lineWidth = dynamicLineWidth
        currentLine = newLine
        updateLineWidth(for: pressure)
    }
    
    func touchMoved(to point: CGPoint, pressure: CGFloat) {
        currentLine?.addPoint(point)
        currentLine?.lineWidth = dynamicLineWidth // 更新当前线条的线宽
        updateLineWidth(for: pressure)
    }
    
    func touchUp() {
        if var currentLine = currentLine {
            currentLine.lineWidth = dynamicLineWidth
            if drawingMode == .pen {
                lines.append(currentLine)
            } else if drawingMode == .eraser {
                eraseLine(at: currentLine)
            }
        }
        self.currentLine = nil
        dynamicLineWidth = baseLineWidth
    }
    
    private func updateLineWidth(for pressure: CGFloat) {
        dynamicLineWidth = min(pressure * 20, baseLineWidth * 2)
    }
    
    func toggleDrawingMode() {
        drawingMode = (drawingMode == .pen) ? .eraser : .pen
    }
    
    func clearDrawing() {
        lines.removeAll()
    }
    
    private func eraseLine(at line: Line) {
        lines = lines.filter { !lineIntersects(line1: $0, line2: line) }
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
