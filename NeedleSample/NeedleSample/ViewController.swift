//
//  ViewController.swift
//  NeedleSample
//
//  Created by Aaron Hanwe LEE on 2022/11/14.
//

import UIKit
import NeedleFoundation

final class ViewController: UIViewController {
  private let questionLabel: UILabel = UILabel()
  private let stackView: UIStackView = UIStackView()
  private let peopleButton: UIButton = UIButton(configuration: .filled())
  private let robotButton: UIButton = UIButton(configuration: .filled())
  
  let robotComponent: RobotComponent
  let peopleComponent: PeopleComponent
  
  init(robot: RobotComponent,
       people: PeopleComponent) {
    robotComponent = robot
    peopleComponent = people
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    setLayout()
    setUI()
  }
  
  private func setLayout() {
    questionLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(questionLabel)
    questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    questionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
    
    view.addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.centerXAnchor.constraint(equalTo: questionLabel.centerXAnchor).isActive = true
    stackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 50).isActive = true
    stackView.widthAnchor.constraint(equalToConstant: 300).isActive = true
    
    stackView.addArrangedSubview(peopleButton)
    stackView.addArrangedSubview(robotButton)
  }
  
  private func setUI() {
    questionLabel.text = "당신은 사람입니까?"
    stackView.spacing = 20
    peopleButton.setTitle("사람입니다", for: .normal)
    let peopleAction = UIAction { _ in
      self.tapPeople()
    }
    peopleButton.addAction(peopleAction, for: .touchUpInside)
    
    robotButton.setTitle("로_봇-입_니-다", for: .normal)
    let robotAction = UIAction { _ in
      self.tapRobot()
    }
    robotButton.addAction(robotAction, for: .touchUpInside)
  }
  
  private func tapPeople() {
    present(peopleComponent.peopleViewController, animated: true)
  }
  
  
  private func tapRobot() {
    present(robotComponent.robotViewController, animated: true)
  }
}

final class SecondViewController: UIViewController {
  private var titleLabel: UILabel = UILabel()
  private let viewModel: ViewModel?
  
  init(viewModel: ViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(titleLabel)
    titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
    titleLabel.font = .systemFont(ofSize: 40)
    titleLabel.textAlignment = .center
    
    titleLabel.text = viewModel?.text
  }
}

protocol RobotDependency: Dependency {
  var prefixTitle: String { get }
}



final class RobotComponent: Component<RobotDependency> {
  var robotViewController: UIViewController {
    SecondViewController(viewModel: viewModel)
  }
  
  var viewModel: ViewModel {
    mutableViewModel
  }
}

extension RobotComponent {
  var mutableViewModel: ViewModel {
    shared { RobotViewModel(text: "\(dependency.prefixTitle)로봇 입니다 🤖") }
  }
}

protocol PeopleDependency: Dependency {
  var prefixTitle: String { get }
}

final class PeopleComponent: Component<PeopleDependency> {
  var peopleViewController: UIViewController {
    SecondViewController(viewModel: viewModel)
  }
  
  var viewModel: ViewModel {
    mutableViewModel
  }
}

extension PeopleComponent {
  var mutableViewModel: ViewModel {
    shared { PeopleViewModel(text: "\(dependency.prefixTitle)사람 입니다 🙇🏻‍♂️") }
  }
}

final class RootComponent: BootstrapComponent {
  var prefixTitle: String { "당신은..." }
  var someProperty: String { "어떤 프로퍼티" }
  
  var rootViewController: UIViewController {
    ViewController(
      robot: robotComponent,
      people: peopleComponent
    )
  }
  
  var robotComponent: RobotComponent {
    RobotComponent(parent: self)
  }
  
  var peopleComponent: PeopleComponent {
    PeopleComponent(parent: self)
  }
}


protocol ViewModel {
  var text: String { get }
}

final class RobotViewModel: ViewModel {
  let text: String
  
  init(text: String) {
    self.text = text
  }
}

final class PeopleViewModel: ViewModel {
  let text: String
  
  init(text: String) {
    self.text = text
  }
}

