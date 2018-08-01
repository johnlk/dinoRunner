//
//  GameScene.swift
//  DinoRunner
//
//  Created by John Kuhn on 7/29/18.
//  Copyright © 2018 John Kuhn. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var groundNode: SKNode!
    var groundLoop: SKAction!
    
    var backgroundNode: SKNode!
    
    func createGround() {
        let screenWidth = self.frame.size.width
        
        //ground texture
        let groundTexture = SKTexture(imageNamed: "dino.assets/landscape/ground")
        groundTexture.filteringMode = .nearest
        
        //ground actions
        let groundSpeed = 1.0 / 150 as CGFloat
        let moveGroundLeft = SKAction.moveBy(x: -groundTexture.size().width, y: 0.0, duration: TimeInterval(screenWidth * groundSpeed))
        let resetGround = SKAction.moveBy(x: groundTexture.size().width, y: 0.0, duration: 0.0)
        groundLoop = SKAction.sequence([moveGroundLeft, resetGround])
        
        //ground nodes
        let numberOfGroundNodes = 1 + Int(ceil(screenWidth / groundTexture.size().width))
        let homeButtonPadding = 50.0 as CGFloat
        for i in 0 ..< numberOfGroundNodes {
            let node = SKSpriteNode(texture: groundTexture)
            node.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            node.position = CGPoint(x: CGFloat(i) * groundTexture.size().width, y: groundTexture.size().height + homeButtonPadding)
            groundNode.addChild(node)
        }
    }
    
    func animateGround() {
        let repeatedAnimation = SKAction.repeatForever(groundLoop)
        groundNode.run(repeatedAnimation)
    }
    
    func createAndRunBackground() {
        let screenWidth = self.frame.size.width
        let screenHeight = self.frame.size.height
        
        //textures
        let cloudTexture = SKTexture(imageNamed: "dino.assets/landscape/cloud")
        let moonTexture = SKTexture(imageNamed: "dino.assets/landscape/moon")
        cloudTexture.filteringMode = .nearest
        moonTexture.filteringMode = .nearest
        
        //actions
        let cloudSpeed = 1.0 / 50 as CGFloat
        let moonSpeed = 1.0 / 5 as CGFloat
        
        let cloudPadding = screenWidth / 3
        let moveMoon = SKAction.moveBy(x: -screenWidth - 100, y: 0.0, duration: TimeInterval(screenWidth * moonSpeed))
        let resetMoon = SKAction.moveBy(x: screenWidth + 100, y: 0.0, duration: 0)
        let moonLoop = SKAction.sequence([moveMoon, resetMoon])
        
        //clouds
        let numClouds = 3
        for i in 0 ..< numClouds {
            let cloudSprite = SKSpriteNode(texture: cloudTexture)
            cloudSprite.position = CGPoint(x: screenWidth + 50 + cloudPadding * CGFloat(i),
                                           y: screenHeight - 200 - CGFloat(i * 50))
            
            let moveCloud = SKAction.moveBy(x: -screenWidth - 100 - cloudPadding * CGFloat(i),
                                            y: 0.0, duration: TimeInterval((screenWidth + cloudPadding * CGFloat(i)) * cloudSpeed))
            let resetCloud = SKAction.moveBy(x: screenWidth + 100 + cloudPadding * CGFloat(i),
                                             y: 0.0, duration: 0.0)
            let cloudLoop = SKAction.sequence([moveCloud, resetCloud])
            
            backgroundNode.addChild(cloudSprite)
            cloudSprite.run(SKAction.repeatForever(cloudLoop))
        }
        
        //moon sprite
        let moonSprite = SKSpriteNode(texture: moonTexture)
        moonSprite.position = CGPoint(x: screenWidth - 50, y: screenHeight - 150)
        
        backgroundNode.addChild(moonSprite)
        
        moonSprite.run(SKAction.repeatForever(moonLoop))
    }
    
    override func didMove(to view: SKView) {
        
        view.backgroundColor = .red
        
        //ground
        groundNode = SKNode()
        self.addChild(groundNode)
        createGround()
        animateGround()
        
        //background elements
        backgroundNode = SKNode()
        self.addChild(backgroundNode)
        createAndRunBackground()
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
