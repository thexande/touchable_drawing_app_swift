//
//  ViewController.swift
//  draw_test
//
//  Created by Alex Murphy on 9/20/17.
//  Copyright © 2017 thexande. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    var touch : UITouch!
    var lineArray : [[CGPoint]] = [[CGPoint]()]
    var index = -1
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touch = touches.first! as UITouch
        let lastPoint = touch.location(in: self)
        
        index += 1
        lineArray.append([CGPoint]())
        lineArray[index].append(lastPoint)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touch = touches.first! as UITouch
        let currentPoint = touch.location(in: self)
        
        self.setNeedsDisplay()
        
        lineArray[index].append(currentPoint)
        
    }
    
    override func draw(_ rect: CGRect) {
        if(index >= 0){
            let context = UIGraphicsGetCurrentContext()
            context!.setLineWidth(5)
            context!.setStrokeColor((UIColor(red:0.00, green:0.38, blue:0.83, alpha:1.0)).cgColor)
            context!.setLineCap(.round)
            
            var j = 0
            while( j <= index ){
                context!.beginPath()
                var i = 0
                context?.move(to: lineArray[j][0])
                while(i < lineArray[j].count){
                    context?.addLine(to: lineArray[j][i])
                    i += 1
                }
                
                context!.strokePath()
                j += 1
            }
        }
    }
}

class ViewController: UIViewController {
    let drawView = DrawView()
    override func loadView() {
        self.view = drawView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "clear", style: .plain, target: self, action: #selector(clear))
    }
    
    func clear() {
        self.drawView.lineArray = [[]]
    }
}

