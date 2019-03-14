module App exposing (Model, Msg(..), init, update, view)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Http exposing (post)
import Json.Decode exposing (list, string)
import Url exposing (Url)


type alias Model =
    { fnr : String
    , startDato : String
    , sluttDato : String
    }


postNySykmelding : Cmd Msg
postNySykmelding =
    post
        { url = "https://httpbin.org/post"
        , body = Http.emptyBody
        , expect = Http.expectJson SykmeldingSendt (list string)
        }


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url navKey =
    ( { fnr = "", startDato = "", sluttDato = "" }, Cmd.none )


type Msg
    = Fnr String
    | StartDato String
    | SluttDato String
    | SubmitOpprettSykmelding
    | SykmeldingSendt (Result Http.Error (List String))
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Fnr fnr ->
            ( { model | fnr = fnr }, Cmd.none )

        StartDato startDato ->
            ( { model | startDato = startDato }, Cmd.none )

        SluttDato sluttDato ->
            ( { model | sluttDato = sluttDato }, Cmd.none )

        SykmeldingSendt _ ->
            ( model, Cmd.none )

        SubmitOpprettSykmelding ->
            ( model, postNySykmelding )

        NoOp ->
            ( model, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = "Syfomock"
    , body =
        [ div []
            [ h1 [] [ text "Syfomock" ]
            , article []
                [ h2 [] [ text "Opprett sykmelding" ]
                , div []
                    [ viewInput "text" "Fnr" model.fnr Fnr
                    , viewInput "text" "Start dato" model.startDato StartDato
                    , viewInput "text" "Slutt dato" model.sluttDato SluttDato
                    , viewValidation model
                    , button [ onClick SubmitOpprettSykmelding ] [ text "Opprett sykmelding" ]
                    ]
                ]
            ]
        ]
    }


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []


viewValidation : Model -> Html msg
viewValidation model =
    if String.length model.fnr == 11 then
        div [ style "color" "green" ] [ text "OK" ]

    else
        div [ style "color" "red" ] [ text "Feil lengde på fødselsnummer" ]
