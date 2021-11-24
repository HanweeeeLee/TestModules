//
//  SecureEnclaveModule.swift
//  SecureEnclaveSample
//
//  Created by hanwe lee on 2021/11/24.
//

import Foundation
import Security

class SecureEnclaveModule {
    // MARK: internal func
    
    func createAccessControl(accessibility: SecureEnclaveModule.Accessibility, policy: SecureEnclaveModule.AuthenticationPolicy) -> Result<SecAccessControl, Error> {
        let policy: SecAccessControlCreateFlags = SecAccessControlCreateFlags(rawValue: policy.rawValue)
        var error: Unmanaged<CFError>?
        guard let accessControl = SecAccessControlCreateWithFlags(kCFAllocatorDefault, accessibility.rawValue as CFTypeRef, SecAccessControlCreateFlags(rawValue: CFOptionFlags(policy.rawValue)), &error) else {
            if let error = error?.takeUnretainedValue() {
                return .failure(error)
            }
            return .failure(SecureEnclaveModuleError.unexpected)
        }
        return .success(accessControl)
    }
    
    
    // MARK: private func
}

extension SecureEnclaveModule {
    enum Accessibility {
        var rawValue: String {
            switch self {
            case .whenUnlocked:
                return String(kSecAttrAccessibleWhenUnlocked)
            case .afterFirstUnlock:
                return String(kSecAttrAccessibleAfterFirstUnlock)
            #if !targetEnvironment(macCatalyst)
            case .always:
                return String(kSecAttrAccessibleAlways)
            #endif
            case .whenPasscodeSetThisDeviceOnly:
                if #available(OSX 10.10, *) {
                    return String(kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly)
                } else {
                    fatalError("'Accessibility.WhenPasscodeSetThisDeviceOnly' is not available on this version of OS.")
                }
            case .whenUnlockedThisDeviceOnly:
                return String(kSecAttrAccessibleWhenUnlockedThisDeviceOnly)
            case .afterFirstUnlockThisDeviceOnly:
                return String(kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly)
            #if !targetEnvironment(macCatalyst)
            case .alwaysThisDeviceOnly:
                return String(kSecAttrAccessibleAlwaysThisDeviceOnly)
            #endif
            }
        }
        
        /**
         Item data can only be accessed
         while the device is unlocked. This is recommended for items that only
         need be accesible while the application is in the foreground. Items
         with this attribute will migrate to a new device when using encrypted
         backups.
         */
        case whenUnlocked

        /**
         Item data can only be
         accessed once the device has been unlocked after a restart. This is
         recommended for items that need to be accesible by background
         applications. Items with this attribute will migrate to a new device
         when using encrypted backups.
         */
        case afterFirstUnlock

        /**
         Item data can always be accessed
         regardless of the lock state of the device. This is not recommended
         for anything except system use. Items with this attribute will migrate
         to a new device when using encrypted backups.
         */
        @available(macCatalyst, unavailable)
        case always

        /**
         Item data can
         only be accessed while the device is unlocked. This class is only
         available if a passcode is set on the device. This is recommended for
         items that only need to be accessible while the application is in the
         foreground. Items with this attribute will never migrate to a new
         device, so after a backup is restored to a new device, these items
         will be missing. No items can be stored in this class on devices
         without a passcode. Disabling the device passcode will cause all
         items in this class to be deleted.
         */
        @available(iOS 8.0, OSX 10.10, *)
        case whenPasscodeSetThisDeviceOnly

        /**
         Item data can only
         be accessed while the device is unlocked. This is recommended for items
         that only need be accesible while the application is in the foreground.
         Items with this attribute will never migrate to a new device, so after
         a backup is restored to a new device, these items will be missing.
         */
        case whenUnlockedThisDeviceOnly

        /**
         Item data can
         only be accessed once the device has been unlocked after a restart.
         This is recommended for items that need to be accessible by background
         applications. Items with this attribute will never migrate to a new
         device, so after a backup is restored to a new device these items will
         be missing.
         */
        case afterFirstUnlockThisDeviceOnly

        /**
         Item data can always
         be accessed regardless of the lock state of the device. This option
         is not recommended for anything except system use. Items with this
         attribute will never migrate to a new device, so after a backup is
         restored to a new device, these items will be missing.
         */
        @available(macCatalyst, unavailable)
        case alwaysThisDeviceOnly
    }
    
    struct AuthenticationPolicy: OptionSet {
        /**
         User presence policy using Touch ID or Passcode. Touch ID does not
         have to be available or enrolled. Item is still accessible by Touch ID
         even if fingers are added or removed.
         */
        @available(iOS 8.0, OSX 10.10, watchOS 2.0, tvOS 8.0, *)
        public static let userPresence = AuthenticationPolicy(rawValue: 1 << 0)

        /**
         Constraint: Touch ID (any finger) or Face ID. Touch ID or Face ID must be available. With Touch ID
         at least one finger must be enrolled. With Face ID user has to be enrolled. Item is still accessible by Touch ID even
         if fingers are added or removed. Item is still accessible by Face ID if user is re-enrolled.
         */
        @available(iOS 11.3, OSX 10.13.4, watchOS 4.3, tvOS 11.3, *)
        public static let biometryAny = AuthenticationPolicy(rawValue: 1 << 1)

        /**
         Deprecated, please use biometryAny instead.
         */
        @available(iOS, introduced: 9.0, deprecated: 11.3, renamed: "biometryAny")
        @available(OSX, introduced: 10.12.1, deprecated: 10.13.4, renamed: "biometryAny")
        @available(watchOS, introduced: 2.0, deprecated: 4.3, renamed: "biometryAny")
        @available(tvOS, introduced: 9.0, deprecated: 11.3, renamed: "biometryAny")
        public static let touchIDAny = AuthenticationPolicy(rawValue: 1 << 1)

        /**
         Constraint: Touch ID from the set of currently enrolled fingers. Touch ID must be available and at least one finger must
         be enrolled. When fingers are added or removed, the item is invalidated. When Face ID is re-enrolled this item is invalidated.
         */
        @available(iOS 11.3, OSX 10.13, watchOS 4.3, tvOS 11.3, *)
        public static let biometryCurrentSet = AuthenticationPolicy(rawValue: 1 << 3)

        /**
         Deprecated, please use biometryCurrentSet instead.
         */
        @available(iOS, introduced: 9.0, deprecated: 11.3, renamed: "biometryCurrentSet")
        @available(OSX, introduced: 10.12.1, deprecated: 10.13.4, renamed: "biometryCurrentSet")
        @available(watchOS, introduced: 2.0, deprecated: 4.3, renamed: "biometryCurrentSet")
        @available(tvOS, introduced: 9.0, deprecated: 11.3, renamed: "biometryCurrentSet")
        public static let touchIDCurrentSet = AuthenticationPolicy(rawValue: 1 << 3)

        /**
         Constraint: Device passcode
         */
        @available(iOS 9.0, OSX 10.11, watchOS 2.0, tvOS 9.0, *)
        public static let devicePasscode = AuthenticationPolicy(rawValue: 1 << 4)

        /**
         Constraint: Watch
         */
        @available(iOS, unavailable)
        @available(OSX 10.15, *)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        public static let watch = AuthenticationPolicy(rawValue: 1 << 5)

        /**
         Constraint logic operation: when using more than one constraint,
         at least one of them must be satisfied.
         */
        @available(iOS 9.0, OSX 10.12.1, watchOS 2.0, tvOS 9.0, *)
        public static let or = AuthenticationPolicy(rawValue: 1 << 14)

        /**
         Constraint logic operation: when using more than one constraint,
         all must be satisfied.
         */
        @available(iOS 9.0, OSX 10.12.1, watchOS 2.0, tvOS 9.0, *)
        public static let and = AuthenticationPolicy(rawValue: 1 << 15)

        /**
         Create access control for private key operations (i.e. sign operation)
         */
        @available(iOS 9.0, OSX 10.12.1, watchOS 2.0, tvOS 9.0, *)
        public static let privateKeyUsage = AuthenticationPolicy(rawValue: 1 << 30)

        /**
         Security: Application provided password for data encryption key generation.
         This is not a constraint but additional item encryption mechanism.
         */
        @available(iOS 9.0, OSX 10.12.1, watchOS 2.0, tvOS 9.0, *)
        public static let applicationPassword = AuthenticationPolicy(rawValue: 1 << 31)

        #if swift(>=2.3)
        public let rawValue: UInt

        public init(rawValue: UInt) {
            self.rawValue = rawValue
        }
        #else
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        #endif
    }
    
    enum SecureEnclaveModuleError: Int, Error {
        case unexpected = -99999
    }
}
