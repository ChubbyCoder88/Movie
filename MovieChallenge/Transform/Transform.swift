//
//  Transform.swift
//  MovieChallenge
//
//  Created by Matthew Corry on 6/4/2023.
//

import Foundation
import Combine

struct Transform {

    func refactorAndInsertIntoViewModel(data: moviesStruct) -> Future <[movieViewModel], AsyncError> {
        var array = [movieViewModel]()
        var d = DateFormatter()
        data.results.forEach {
            var title = "".ifLet(s: $0?.title)
            var overview = "".ifLet(s: $0?.overview)
            var image = "".ifLet(s: $0?.poster_path)
            var releaseDate = "".sReFormatDate(s: "".ifLet(s: $0?.release_date), form1: d.format(s: "yyyy-MM-dd"), form2: d.format(s: "dd MMMM yyyy"))
            var backdropImage = "".ifLet(s: $0?.backdrop_path)
            var vote = "".makeStringBetween(s: "".sDoubleToString(d: $0?.vote_average), A: 0, B: 2)
            var voteCount = "".ifLetItS(i: $0?.vote_count) + " votes"
            var favMatched = true.sInData(s: title, d: favData0)

            var input = movieViewModel(title: title, release_date: releaseDate, poster_image: image, overview: overview, vote_average: vote, backdrop_image: backdropImage, vote_count: voteCount, isFavourite: favMatched)
            array.append(input)
        }
        return Future() { promise in
        array.count < 1 ? promise(Result.failure(AsyncError.message("Re fail"))) : promise(Result.success(array)); array.removeAll()
        }
    }
}

enum AsyncError: Error {
    case message(String)
}
