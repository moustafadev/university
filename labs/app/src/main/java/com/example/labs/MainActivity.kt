package com.example.labs

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
<<<<<<< HEAD
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
=======
import androidx.compose.foundation.layout.fillMaxSize
>>>>>>> 0ffd9e0 (hallo android)
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
<<<<<<< HEAD
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.layout.VerticalAlignmentLine
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
=======
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
>>>>>>> 0ffd9e0 (hallo android)
import com.example.labs.ui.theme.LabsTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            LabsTheme {
                // A surface container using the 'background' color from the theme
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
<<<<<<< HEAD
                    BirthdayCardPreview()
=======
                    Greeting("Android")
>>>>>>> 0ffd9e0 (hallo android)
                }
            }
        }
    }
}

<<<<<<< HEAD
//@Composable
//fun Greeting(name: String, modifier: Modifier = Modifier) {
//    Text(
//        text = "Hello $name!",
//        modifier = modifier
//    )
//}

//@Preview(showBackground = true)
//@Composable
//fun GreetingPreview() {
//    LabsTheme {
//        Greeting("Android")
//    }
//}


@Preview(showBackground = false)
@Composable
fun BirthdayCardPreview() {
    LabsTheme {
        GreetingImage("Happy Birthday Mostafa!", "From Emma")
    }
}
@Composable
fun GreetingImage(message: String, from: String, modifier: Modifier = Modifier) {
    val image = painterResource(R.drawable.androidparty)
    Box {
        Image(
            painter = image,
            contentDescription = null ,
            contentScale = ContentScale.Crop,
            alpha = 0.5F
        )

        GreetingText(
            message = message,
            from = from,
            modifier = Modifier
                .fillMaxSize()
                .padding(10.dp)
        )
    }
}

@Composable
fun GreetingText(message: String, from: String, modifier: Modifier) {
    Column(
        modifier = Modifier.padding(),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text(
            text = message,
            modifier = modifier,
            fontSize = 50.sp,
            textAlign = TextAlign.Center,
            color = Color.Black,
        )
        Text(
            text = from,
            modifier = modifier,
            fontSize = 50.sp,
            textAlign = TextAlign.End,
            color = Color.Black,
        )
    }
}
=======
@Composable
fun Greeting(name: String, modifier: Modifier = Modifier) {
    Text(
        text = "Hello $name!",
        modifier = modifier
    )
}

@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    LabsTheme {
        Greeting("Android")
    }
}
>>>>>>> 0ffd9e0 (hallo android)
