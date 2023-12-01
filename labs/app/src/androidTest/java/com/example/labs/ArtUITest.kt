package com.example.labs

import androidx.compose.ui.test.junit4.createComposeRule
import androidx.compose.ui.test.onNodeWithText
import androidx.compose.ui.test.performClick
import org.junit.Rule
import org.junit.Test

class ArtUITest {
    @get:Rule
    val composeTestRule = createComposeRule()

    @Test
    fun testArtSpaceScreen() {
        composeTestRule.setContent {
            ArtSpaceScreen()
        }
        composeTestRule.onNodeWithText("Next").assertExists()
        composeTestRule.onNodeWithText("Previous").assertExists()


        composeTestRule.onNodeWithText("Next").performClick()
    }
}