module Main exposing (..)

import Html exposing (Html, Attribute, div, p, abbr, input, label, text, button)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- Model --


type alias Model =
    { email1 : String
    , email2 : String
    , canSubmit : Bool
    }


model : Model
model =
    { email1 = ""
    , email2 = ""
    , canSubmit = False
    }



-- Update


type Msg
    = Email1Changed String
    | Email2Changed String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Email1Changed newEmail ->
            { model | email1 = newEmail }

        Email2Changed newEmail ->
            { model | email2 = newEmail }


view : Model -> Html Msg
view model =
    div []
        [ p []
            [ label [ for "email1" ] [ text "Email:" ]
            , input [ type_ "text", name "email1", onInput Email1Changed ] []
            , label [ for "email1" ] [ abbr [ title "required" ] [ text "*" ] ]
            ]
        , p []
            [ label [ for "email2" ] [ text "Email confirmation:" ]
            , input [ type_ "text", name "email2", onInput Email2Changed ] []
            , label [ for "email2" ] [ abbr [ title "required" ] [ text "*" ] ]
            ]
        , viewValidation model
        ]


viewValidation : Model -> Html msg
viewValidation model =
    let
        ( color, message ) =
            if model.email1 /= "" && model.email1 == model.email2 then
                ( "green", "OK" )
            else
                ( "red", "emails don't match" )
    in
        div
            [ style [ ( "color", color ) ] ]
            [ text message ]
