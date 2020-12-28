Feature: Acquisition Form

    This is a form that gets info from acquisitions and store them in a
    Google Sheets file.

    Scenario: Happy Path
        When I fill the 'titleField' field with 'Compras de Limpeza'
        And I fill the 'valueField' field with '2.87'
        And I tap the "sendButton" button
        Then I wait until the element of type "ProgressIndicator" is absent
        And I wait until the element of type "AlertDialog" is present

    Scenario: Empty title validator
        When I tap the "sendButton" button
        Then I expect the text "Escreva alguma coisa aqui!" to be present

    Scenario: Member field memory test
        When I tap the "memberDropdown" element
        And I tap the "Fuga" text
        And I restart the app
        Then I expect the text "Fuga" to be present within the "memberDropdown"