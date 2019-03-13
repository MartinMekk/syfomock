module App exposing (Model, Msg(..), init, update, view)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, div, text)
import Url exposing (Url)


type alias Model =
    { message : String
    }


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url navKey =
    ( { message = "Hello world!" }, Cmd.none )


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = "Syfomock"
    , body =
        [ div []
            [ div [] [ text model.message ]
            ]
        ]
    }
