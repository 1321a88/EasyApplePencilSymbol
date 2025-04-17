import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = DrawingViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                DrawingCanvasView(viewModel: viewModel)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                    .border(Color.black, width: 1)
                
                if viewModel.drawingMode == .eraser {
                    Circle()
                        .stroke(Color.red, lineWidth: 2)
                        .frame(width: viewModel.eraseCircleRadius * 2, height: viewModel.eraseCircleRadius * 2)
                        .position(viewModel.eraseCircleCenter)
                }
            }
            
            HStack {
                Button(action: {
                    viewModel.toggleDrawingMode()
                }) {
                    Text(viewModel.drawingMode == .pen ? "Eraser" : "Pen")
                        .padding()
                        .background(viewModel.drawingMode == .pen ? Color.blue : Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Spacer()
                
                Button("Clear") {
                    viewModel.clearDrawing()
                }
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding(.horizontal)
            
            Slider(value: $viewModel.baseLineWidth, in: 1...10, step: 1)
                .padding()
                .accentColor(.blue)
            
            Text("Line Width: \(Int(viewModel.baseLineWidth))")
                .padding()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct DrawingCanvasView: View {
    @ObservedObject var viewModel: DrawingViewModel
    
    var body: some View {
        GeometryReader { geometry in
            Canvas { context, size in
                for line in viewModel.lines {
                    var path = Path()
                    if let firstPoint = line.points.first {
                        path.move(to: firstPoint)
                        for point in line.points.dropFirst() {
                            path.addLine(to: point)
                        }
                    }
                    context.stroke(path, with: .color(.black), lineWidth: line.lineWidth)
                }
                
                // 绘制当前线条
                if let currentLine = viewModel.currentLine {
                    var path = Path()
                    if let firstPoint = currentLine.points.first {
                        path.move(to: firstPoint)
                        for point in currentLine.points.dropFirst() {
                            path.addLine(to: point)
                        }
                    }
                    context.stroke(path, with: .color(.black), lineWidth: currentLine.lineWidth)
                }
            }
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged { value in
                    let point = value.location
                    let pressure = value.location.distance(to: value.startLocation) / 100
                    if value.translation == .zero {
                        viewModel.touchDown(at: point, pressure: pressure)
                    } else {
                        viewModel.touchMoved(to: point, pressure: pressure)
                    }
                }
                .onEnded { _ in
                    viewModel.touchUp()
                })
        }
    }
}
