//
//  ContainerViewController.swift
//  Pitch Events
//
//  Created by Austin Delk on 3/23/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

enum MenuState{
    case Collapsed
    case Expanded
}

enum NavBarState{
    case Shown
    case Hidden
}

class ContainerViewController: UIViewController, EventTableViewControllerDelegate {
    
    var loginViewController: LoginViewController!
    var eventTableNavigationController: UINavigationController!
    var eventTableViewController: EventTableViewController!
    var currentState: MenuState = .Collapsed
    var navBarState: NavBarState = .Shown
    var menuViewController: MenuPanelViewController?
    
    let menuPanelExpandedOffset: CGFloat = 60 //How much of the event table view should stay visible
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTableViewController = UIStoryboard.eventTableViewController()
        eventTableViewController.delegate = self
        
        //wrap the eventTableViewController in a navigation controller, so we can push views to it and display bar button items in the navigation bar
        eventTableNavigationController = UINavigationController(rootViewController: eventTableViewController)
        view.addSubview(eventTableNavigationController.view)
        addChildViewController(eventTableNavigationController)
        
        eventTableNavigationController.didMoveToParentViewController(self)
        
        loginViewController = UIStoryboard.loginViewController()
        eventTableNavigationController.pushViewController(loginViewController, animated: false)
        //eventTableNavigationController.setNavigationBarHidden(true, animated: false)

    }
    
    func setEventTableDelegate(){
        if(self.isMovingToParentViewController()){
            eventTableViewController = UIStoryboard.eventTableViewController()
            eventTableViewController.delegate = self

        }
        
    }
    
    func toggleMenuPanel(){
        //checks if menu is already expanded, IF not then panel is added and animated to open. If already then it is animated to closed
        let notAlreadyExpanded = (currentState != .Expanded)
        
        if(notAlreadyExpanded){
            addMenuPanelViewController()
        }
        
        animateMenuPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func addMenuPanelViewController(){
        if(menuViewController == nil){
            menuViewController = UIStoryboard.menuViewController()
            //menuViewController!.animals - Animal.allCats()
            
            addChildMenuPanelController(menuViewController!)
        }
    }
    
    func addChildMenuPanelController(menuPanelController: MenuPanelViewController){
        view.insertSubview(menuPanelController.view, atIndex: 0)
        
        addChildViewController(menuPanelController)
        menuPanelController.didMoveToParentViewController(self)
    }
    
    func animateMenuPanel(#shouldExpand: Bool){
        if(shouldExpand){
            currentState = .Expanded
            
            animateEventTablePanelXPosition(targetPosition: CGRectGetWidth(eventTableNavigationController.view.frame) - menuPanelExpandedOffset)
        } else {
            animateEventTablePanelXPosition(targetPosition: 0){ finished in
                self.currentState = .Collapsed
                
                self.menuViewController!.view.removeFromSuperview()
                self.menuViewController = nil
            }
        }
    }
    
    func animateEventTablePanelXPosition(#targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil){
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.eventTableNavigationController.view.frame.origin.x = targetPosition
            }, completion: completion)
    }
    
    func handlePanGesture(recognizer: UIPanGestureRecognizer){
        
    }
}

private extension UIStoryboard {
    
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    
    class func menuViewController() -> MenuPanelViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("MenuViewController") as? MenuPanelViewController
    }
    
    class func eventTableViewController() -> EventTableViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("EventTableViewController") as? EventTableViewController
    }
    
    class func loginViewController() -> LoginViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("LoginViewController") as? LoginViewController
    }
}