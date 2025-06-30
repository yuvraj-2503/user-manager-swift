//
//  RetryableFuture.swift
//  user-manager
//
//  Created by Yuvraj Singh on 29/06/25.
//

public final class RetryableFuture<T: Sendable> {
    private let operation: @Sendable () async throws -> T
    private var task: Task<T, Error>?

    public init(operation: @escaping @Sendable () async throws -> T) {
        self.operation = operation
        self.task = Task { try await operation() }
    }

    public func get() async throws -> T {
        guard let task else {
            throw InternalError()
        }
        return try await task.value
    }

    public func retry() {
        let op = operation
        task = Task {
            try await op()
        }
    }

    public func cancel() {
        task?.cancel()
    }
}
