//
//  GameScene.swift
//  InkBounce
//
//  Created by Vibhu Gandikota on 12/17/16.
//  Copyright © 2016 Vibhu Gandikota. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    
    
    //Create Global Variables
    var score = 0
    var timer = Timer()
    var scoreLabel = SKLabelNode()
    var Ball = SKShapeNode(circleOfRadius: 30)
    var ref = CGMutablePath()
    let bottom = SKShapeNode()
    var wayPoints: [CGPoint] = []

    var gameOver = false
    
    
    func GameOver(){
        Ball.removeFromParent()
        print("Game Over")
    }

    
    func initHud(){
        //set Scene Color
        
        //let shape = SKShapeNode()
        let path = CGMutablePath()
        path.move(to: CGPoint(x: frame.minX, y: frame.minY))
        path.addLine(to: CGPoint(x: frame.maxX, y: frame.minY + 10))
        
        bottom.path = path
        bottom.strokeColor = SKColor .clear
        bottom.lineWidth = 2
        bottom.removeFromParent()
        addChild(bottom)
        
       /* shape.position = CGPoint(x: frame.midX, y: frame.midY)
        shape.fillColor = SKColor .blue
        shape.strokeColor = SKColor .blue
        shape.lineWidth = 10
        shape.removeFromParent()
        addChild(shape)
        */
        self.scene?.backgroundColor = SKColor .white
        
        gameOver = false
       
        
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.5)

        
        scoreLabel.fontName = "Helvetica Neue Bold"
        scoreLabel.fontSize = 100
        scoreLabel.fontColor = SKColor .black
        
        scoreLabel.text = score.description

        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY + 500)
        scoreLabel.removeFromParent()
        self.addChild(scoreLabel)
        
        addBall()
        
        
        
        
    }
    
    func randomInRange(lo: Int, hi : Int) -> Int {
        return lo + Int(arc4random_uniform(UInt32(hi - lo + 1)))
    }
    
        func addBall(){
        

        // x coordinate between MinX (left) and MaxX (right):
        let randomX = randomInRange(lo: Int(self.frame.minX + 15), hi: Int(self.frame.maxX - 15))
        // y coordinate between MinY (top) and MidY (middle):
        let randomY = randomInRange(lo: Int(self.frame.midY), hi: Int(self.frame.maxY - 15))
        let randomPoint = CGPoint(x: randomX, y: randomY)
        
        
        Ball.name = "Ball"
        Ball.fillColor = SKColor(red: 143, green: 255, blue: 250, alpha: 1)
        Ball.strokeColor = SKColor(red: 143, green: 255, blue: 250, alpha: 1)
        Ball.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        Ball.position = randomPoint
        Ball.physicsBody?.isDynamic = true
        Ball.physicsBody?.affectedByGravity = true
        
        Ball.removeFromParent()
        self.addChild(Ball)
        
        
    }
    

    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0

        
        initHud()
    }
    
    
    
    override func didMove(to view: SKView) {
        //scene bounderies

        // 1
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        // 2
        borderBody.friction = 0
        // 3
        self.physicsBody = borderBody
        
        
    }

    
    func touchDown(atPoint pos : CGPoint) {
       
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self))
        
        wayPoints.append(t.location(in: self))
            
            print(wayPoints)
    }
        
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self))
        
            wayPoints.append(t.location(in: self))
        print(wayPoints)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self))
        
        wayPoints = []
            
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }

    
    /*
    
    
    func touchDown(atPoint pos : CGPoint) {
           }
    
    func touchMoved(toPoint pos : CGPoint) {
     for touch: AnyObject in touches {
     let locationInScene = touch.locationInNode(self)
     var line = SKShapeNode()
     CGPathAddLineToPoint(ref, nil, locationInScene.x, locationInScene.y)
     line.path = ref
     line.lineWidth = 4
     line.fillColor = UIColor.redColor()
     line.strokeColor = UIColor.redColor()
     self.addChild(line)
     }
     }
            }
    
    func touchUp(atPoint pos : CGPoint) {
            }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
     if let touch = touches.anyObject() as? UITouch {
     let location = touch.locationInNode(self)
     CGPathMoveToPoint(ref, nil, location.x, location.y)
     }
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    */
    
    override func update(_ currentTime: TimeInterval) {
        
        scoreLabel.text = score.description
        
        
        if Ball.intersects(bottom) {
            GameOver()
        }
       
       
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
        
        drawLines()
        
    }
 
    
    
    
    
    
    func createPathToMove() -> CGPath? {
        //1
        if wayPoints.count <= 1 {
            return nil
        }
        //2
        var ref = CGMutablePath()
        
        //3
        for i in 0 ..< wayPoints.count {
            let p = wayPoints[i]
            
            //4
            if i == 0 {
                ref.move(to: CGPoint(x: p.x, y: p.y))
            } else {
                ref.addLine(to: CGPoint(x: p.x, y: p.y))
                
            }
            
        }
        return ref

    }

 
    
    func drawLines() {
        //1
        enumerateChildNodes(withName: "line", using: {node, stop in
            node.removeFromParent()
        })
        
        //2
            //3
            if let path = self.createPathToMove() {
                let shapeNode = SKShapeNode()
                shapeNode.path = path
                shapeNode.name = "line"
                shapeNode.strokeColor = SKColor .black
                shapeNode.lineWidth = 5
                shapeNode.zPosition = 1
                
                self.addChild(shapeNode)
            }
        
    }
    
    
}
    
    
    

