

import NeedleFoundation
import UIKit

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Traversal Helpers

private func parent1(_ component: NeedleFoundation.Scope) -> NeedleFoundation.Scope {
    return component.parent
}

// MARK: - Providers

#if !NEEDLE_DYNAMIC

private class RobotDependencye99bc2ffbef957ece814Provider: RobotDependency {
    var prefixTitle: String {
        return rootComponent.prefixTitle
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->RobotComponent
private func factoryf9cb583eac419c43186ab3a8f24c1d289f2c0f2e(_ component: NeedleFoundation.Scope) -> AnyObject {
    return RobotDependencye99bc2ffbef957ece814Provider(rootComponent: parent1(component) as! RootComponent)
}
private class PeopleDependencya9b9e0a234681c21544fProvider: PeopleDependency {
    var prefixTitle: String {
        return rootComponent.prefixTitle
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->PeopleComponent
private func factorya0007c81aad3afe22b1db3a8f24c1d289f2c0f2e(_ component: NeedleFoundation.Scope) -> AnyObject {
    return PeopleDependencya9b9e0a234681c21544fProvider(rootComponent: parent1(component) as! RootComponent)
}

#else
extension RobotComponent: Registration {
    public func registerItems() {
        keyPathToName[\RobotDependency.prefixTitle] = "prefixTitle-String"
    }
}
extension PeopleComponent: Registration {
    public func registerItems() {
        keyPathToName[\PeopleDependency.prefixTitle] = "prefixTitle-String"
    }
}
extension RootComponent: Registration {
    public func registerItems() {


    }
}


#endif

private func factoryEmptyDependencyProvider(_ component: NeedleFoundation.Scope) -> AnyObject {
    return EmptyDependencyProvider(component: component)
}

// MARK: - Registration
private func registerProviderFactory(_ componentPath: String, _ factory: @escaping (NeedleFoundation.Scope) -> AnyObject) {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: componentPath, factory)
}

#if !NEEDLE_DYNAMIC

private func register1() {
    registerProviderFactory("^->RootComponent->RobotComponent", factoryf9cb583eac419c43186ab3a8f24c1d289f2c0f2e)
    registerProviderFactory("^->RootComponent->PeopleComponent", factorya0007c81aad3afe22b1db3a8f24c1d289f2c0f2e)
    registerProviderFactory("^->RootComponent", factoryEmptyDependencyProvider)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
