package com.example.labs

import androidx.annotation.DrawableRes
import androidx.annotation.StringRes
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.colorResource
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp



@Composable
fun ArtSpaceScreen(modifier: Modifier = Modifier) {
    val firstArtwork = R.drawable.denji_face
    val secondArtwork = R.drawable.zero_two_face
    val thirdArtwork = R.drawable.sanji_face
    val fourthArtwork = R.drawable.naruto_face

    var title by remember {
        mutableStateOf(R.string.denji)
    }

    var year by remember {
        mutableStateOf(R.string.denji_year)
    }

    var currentArtwork by remember {
        mutableStateOf(firstArtwork)
    }


    Column(
        modifier = modifier
            .fillMaxWidth(),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        ArtworkDisplay(currentArtwork = currentArtwork)
        Spacer(modifier = modifier.size(16.dp))
        ArtworkTitle(title = title, year = year)
        Spacer(modifier = modifier.size(25.dp))
        Row(
            modifier = modifier.padding(horizontal = 8.dp),
            horizontalArrangement = Arrangement.spacedBy(8.dp, Alignment.CenterHorizontally)
        ) {
            // Previous Button
            Button(
                onClick = {
                    when (currentArtwork) {
                        firstArtwork -> {
                            currentArtwork = fourthArtwork
                            title = R.string.naruto
                            year = R.string.naruto_year
                        }
                        secondArtwork -> {
                            currentArtwork = firstArtwork
                            title = R.string.denji
                            year = R.string.denji_year
                        }
                        thirdArtwork -> {
                            currentArtwork = secondArtwork
                            title = R.string.zero_two
                            year = R.string.zero_two_year
                        }
                        else -> {
                            currentArtwork = thirdArtwork
                            title = R.string.sanji
                            year = R.string.sanji_year
                        }
                    }
                },
                colors = ButtonDefaults.buttonColors(
                    containerColor = colorResource(id = R.color.gray_900)
                ),
                elevation = ButtonDefaults.buttonElevation(
                    defaultElevation = 1.dp,
                    pressedElevation = 0.dp,
                    focusedElevation = 0.dp
                )
            ) {
                Text(
                    text = "Previous",
                    fontSize = 16.sp,
                    fontWeight = FontWeight.Medium,
                    color = colorResource(id = R.color.blue_300)
                )
            }

            // Next Button
            Button(
                onClick = {
                    when (currentArtwork) {
                        firstArtwork -> {
                            currentArtwork = secondArtwork
                            title = R.string.zero_two
                            year = R.string.zero_two_year
                        }
                        secondArtwork -> {
                            currentArtwork = thirdArtwork
                            title = R.string.sanji
                            year = R.string.sanji_year
                        }
                        thirdArtwork -> {
                            currentArtwork = fourthArtwork
                            title = R.string.naruto
                            year = R.string.naruto_year
                        }
                        else -> {
                            currentArtwork = firstArtwork
                            title = R.string.denji
                            year = R.string.denji_year
                        }
                    }
                },
                colors = ButtonDefaults.buttonColors(
                    containerColor = colorResource(id = R.color.blue_300)
                ),
                elevation = ButtonDefaults.buttonElevation(
                    defaultElevation = 1.dp,
                    pressedElevation = 0.dp,
                    focusedElevation = 0.dp
                )
            ) {
                Text(
                    text = "Next",
                    fontSize = 16.sp,
                    fontWeight = FontWeight.Medium,
                    color = colorResource(id = R.color.gray_900)
                )
            }
        }
    }
}

@Composable
fun ArtworkDisplay(
    modifier: Modifier = Modifier,
    @DrawableRes currentArtwork: Int
) {
    Image(
        painter = painterResource(currentArtwork),
        contentDescription = stringResource(id = R.string.zero_two),
        modifier = modifier.fillMaxWidth(),
        contentScale = ContentScale.FillWidth
    )
}

@Composable
fun ArtworkTitle(
    @StringRes title: Int,
    @StringRes year: Int
) {
    Column (
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        // Artwork title
        Text(
            text = stringResource(id = title),
            fontWeight = FontWeight.Bold,
            color = colorResource(id = R.color.blue_100),
            fontSize = 32.sp
        )

        // Artwork year
        Text(
            text = "— ${stringResource(id = year)} —",
            fontSize = 16.sp,
            fontWeight = FontWeight.Medium,
            color = colorResource(id = R.color.gray_300)
        )
    }
}

