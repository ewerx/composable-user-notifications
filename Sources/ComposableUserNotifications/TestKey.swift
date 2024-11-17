import Dependencies
import Foundation
import UserNotifications
import IssueReporting

extension DependencyValues {
  public var userNotifications: UserNotificationClient {
    get { self[UserNotificationClient.self] }
    set { self[UserNotificationClient.self] = newValue }
  }
}

extension UserNotificationClient: TestDependencyKey {
  public static let previewValue = Self.noop

  #if os(iOS) || os(macOS) || os(watchOS) || targetEnvironment(macCatalyst)
    public static let testValue = Self(
      add: unimplemented("\(Self.self).add"),
      deliveredNotifications: unimplemented("\(Self.self).deliveredNotifications", placeholder: []),
      notificationCategories: unimplemented("\(Self.self).notificationCategories", placeholder: []),
      notificationSettings: unimplemented("\(Self.self).notificationSettings"),
      pendingNotificationRequests: unimplemented("\(Self.self).pendingNotificationRequests", placeholder: []),
      removeAllDeliveredNotifications: unimplemented(
        "\(Self.self).removeAllDeliveredNotifications"),
      removeAllPendingNotificationRequests: unimplemented(
        "\(Self.self).removeAllPendingNotificationRequests"
      ),
      removeDeliveredNotificationsWithIdentifiers: unimplemented(
        "\(Self.self).removeDeliveredNotificationsWithIdentifiers"
      ),
      removePendingNotificationRequestsWithIdentifiers: unimplemented(
        "\(Self.self).removePendingNotificationRequestsWithIdentifiers"
      ),
      requestAuthorization: unimplemented("\(Self.self).requestAuthorization", placeholder: false),
      setNotificationCategories: unimplemented("\(Self.self).setNotificationCategories"),
      supportsContentExtensions: unimplemented(
        "\(Self.self).supportsContentExtensions", placeholder: false
      ),
      delegate: unimplemented("\(Self.self).delegate", placeholder: .finished)
    )
  #else  // tvOS
    public static let testValue = Self(
      add: unimplemented("\(Self.self).add"),
      pendingNotificationRequests: unimplemented("\(Self.self).pendingNotificationRequests"),
      removeAllPendingNotificationRequests: unimplemented(
        "\(Self.self).removeAllPendingNotificationRequests"
      ),
      removePendingNotificationRequestsWithIdentifiers: unimplemented(
        "\(Self.self).removePendingNotificationRequestsWithIdentifiers"),
      requestAuthorization: unimplemented("\(Self.self).requestAuthorization", placeholder: false),
      supportsContentExtensions: unimplemented(
        "\(Self.self).supportsContentExtensions", placeholder: false
      ),
      delegate: unimplemented("\(Self.self).delegate", placeholder: .finished)
    )
  #endif
}

extension UserNotificationClient {
  #if os(iOS) || os(macOS) || os(watchOS) || targetEnvironment(macCatalyst)
    public static let noop = Self(
      add: { _ in },
      deliveredNotifications: { [] },
      notificationCategories: { [] },
      notificationSettings: unimplemented("\(Self.self).notificationSettings"),
      pendingNotificationRequests: { [] },
      removeAllDeliveredNotifications: {},
      removeAllPendingNotificationRequests: {},
      removeDeliveredNotificationsWithIdentifiers: { _ in },
      removePendingNotificationRequestsWithIdentifiers: { _ in },
      requestAuthorization: { _ in false },
      setNotificationCategories: { _ in },
      supportsContentExtensions: { false },
      delegate: { AsyncStream { _ in } }
    )
  #else  // tvOS
    public static let noop = Self(
      add: { _ in },
      pendingNotificationRequests: { [] },
      removeAllPendingNotificationRequests: {},
      removePendingNotificationRequestsWithIdentifiers: { _ in },
      requestAuthorization: { _ in false },
      supportsContentExtensions: { false },
      delegate: { AsyncStream { _ in } }
    )
  #endif
}
