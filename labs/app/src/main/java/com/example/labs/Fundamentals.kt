package com.example.labs

fun main() {
    val question1 = Question<String>("Quoth the raven ___", "nevermore", "medium",Difficulty.MEDIUM)
    val question2 = Question<Boolean>("The sky is green. True or false", false, "easy",Difficulty.EASY)
    val question3 = Question<Int>("How many days are there between full moons?", 28, "hard",Difficulty.HARD)

    //// 1111
    println(question2.questionText)
    println(Quiz.progressText)
    Quiz().printProgressBar()

    ///// 2222
    val rockPlanets = arrayOf<String>("Mercury", "Venus", "Earth", "Mars")
    val gasPlanets = arrayOf("Jupiter", "Saturn", "Uranus", "Neptune")
    val solarSystem = rockPlanets + gasPlanets
    println(solarSystem[0])
    solarSystem[3] = "Little Earth"
    println(solarSystem[3])
    val listSolarSystem = listOf("Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune")
    println(listSolarSystem.size)
    println(listSolarSystem.get(3))
    println(solarSystem.indexOf("Pluto"))
    for (planet in solarSystem) {
        println(planet)
    }
    val solarSystemSet = mutableSetOf("Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune")
    println(solarSystemSet.size)
    solarSystemSet.add("Pluto")
    println("Set Size after add ${solarSystemSet.size}")
    solarSystemSet.remove("Pluto")
    println("Set Size before add ${solarSystemSet.size}")
    val solarSystemMap = mutableMapOf(
        "Mercury" to 0,
        "Venus" to 0,
        "Earth" to 1,
        "Mars" to 2,
        "Jupiter" to 79,
        "Saturn" to 82,
        "Uranus" to 27,
        "Neptune" to 14
    )
    println("Map Size${solarSystem.size}")
    solarSystemMap["Pluto"] = 5
    println(solarSystemMap.get("Theia"))
    solarSystemMap["Jupiter"] = 78
    println(solarSystemMap["Jupiter"])

}
class Quiz : ProgressPrintable{
    val question1 = Question<String>("Quoth the raven ___", "nevermore", "medium",Difficulty.MEDIUM)
    val question2 = Question<Boolean>("The sky is green. True or false", false, "easy",Difficulty.EASY)
    val question3 = Question<Int>("How many days are there between full moons?", 28, "hard",Difficulty.HARD)
    companion object StudentProgress {
        var total: Int = 10
        var answered: Int = 3
    }
    override val progressText: String
        get() = "${answered} of ${total} answered"

    override fun printProgressBar() {
        repeat(Quiz.answered) { print("▓") }
        repeat(Quiz.total - Quiz.answered) { print("▒") }
        println()
        println(progressText)
    }

}


interface ProgressPrintable {
    val progressText: String
    fun printProgressBar()

}

//fun Quiz.StudentProgress.printProgressBar() {
//    repeat(Quiz.answered) { print("▓") }
//    repeat(Quiz.total - Quiz.answered) { print("▒") }
//    println()
//    println(Quiz.progressText)
//}

val Quiz.StudentProgress.progressText: String
    get() = "${answered} of ${total} answered"
class Question<T>(
    val questionText: String,
    val answer: T,
    val difficulty: String,
    val difficultyEnum: Difficulty
)


enum class Difficulty {
    EASY, MEDIUM, HARD
}