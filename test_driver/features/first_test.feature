Feature: Simple App Page Testing

    Feature Description

    Scenario: Testing for Happy Path
        When I fill the 'name' field with 'João'
        And I fill the 'surname' field with 'Zanutto'
        And I tap the "send" button
        Then I expect the text 'ihoo' to be present