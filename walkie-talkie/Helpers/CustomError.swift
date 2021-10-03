//
//  CustomError.swift
//  walkie-talkie
//
//  Created by Nika Elashvili on 10/3/21.
//

import Foundation

enum CustomError: Error {
    case AVPlayerNotFound
    case notFound
    case incorrectURL
    case unexpected(code: Int)
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .AVPlayerNotFound:
            return NSLocalizedString("Could not play the message",comment: "AV player is nil")
        case .incorrectURL:
            return NSLocalizedString("Incorrect URL",comment: "Incorrect URL")
        case .notFound:
            return NSLocalizedString(
                "The item could not be found.",
                comment: "Resource Not Found"
            )
        case .unexpected(_):
            return NSLocalizedString(
                "An unexpected error occurred.",
                comment: "Unexpected Error"
            )
        }
    }
}
