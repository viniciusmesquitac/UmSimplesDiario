//
//  ContextualAction.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 17/02/21.
//

import UIKit

protocol SwipeActionDelegate: class {
    func didPerform(action: SwipeAction, index: Int)
}

protocol SwipeAction {

    var color: UIColor { get }
    var title: String { get }
    var style: UIContextualAction.Style { get }

}

class ContextualAction<Action: SwipeAction> {

    private var contextualAction: UIContextualAction?
    var handler: UIContextualAction.Handler?

    private var actions: [Action]!
    private let indexRow: Int
    public var contextuals: [UIContextualAction] = []
    weak var delegate: SwipeActionDelegate?

    init(_ delegate: SwipeActionDelegate?, actions: [Action], index: Int) {
        self.delegate = delegate
        self.indexRow = index
        self.addContextuals(actions: actions)
    }

    public func addContextuals(actions: [Action]) {
        for action in actions {
            self.handler = { _, _, completion in
                self.delegate?.didPerform(action: action, index: self.indexRow)
                completion(true)
            }
            let contextualAction = UIContextualAction(style: action.style, title: action.title, handler: handler!)
            contextualAction.backgroundColor = action.color
            contextuals.append(contextualAction)
        }
    }

    public func setup() -> UISwipeActionsConfiguration? {
        let configuration = UISwipeActionsConfiguration(actions: contextuals)
        contextuals = []
        return configuration
    }

}

enum RegistrosAction: SwipeAction {
    case delete
    
    var color: UIColor {
        switch self {
        case .delete: return UIColor.systemRed
        }
    }
    
    var title: String {
        switch self {
        case .delete: return "Deletar"
        }
    }
    
    var style: UIContextualAction.Style {
        switch self {
        case .delete: return UIContextualAction.Style.destructive
        }
    }
}
