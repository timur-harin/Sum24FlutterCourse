# Middle Assigment: The Contrast Shower Companion

## Project Background:
In the bustling city of Innopolis, Timur found himself engulfed in the monotonous routine of a 9-to-5 job. His days were a blur, with little to distinguish one from the next, until he stumbled upon the concept of contrast showers—a wellness practice involving the alternation of hot and cold water during a shower. Intrigued by the potential benefits, such as improved circulation and invigoration of the mind, Timur decided to integrate this practice into his daily routine.

As Timur delved deeper into this practice, he noticed a remarkable improvement in his focus and energy levels. However, tracking the timing and sequence of temperature changes was cumbersome and interrupted the flow of his experience. It was then that he envisioned a solution—an application that could guide him through the process, log his sessions, and enable him to focus on the therapeutic effects without distraction. Thus, the idea for the Contrast Shower Companion app was born.

## Story:
One brisk morning, as Timur stepped out of his contrast shower, feeling more alive than ever, he was struck by inspiration. "What if there was an app that could orchestrate this entire process?" he pondered. With a spark of creativity, Timur set out to create an application that would not only time his showers but also learn from his preferences, store his history, and help others discover the invigorating power of contrast showers.

As the app took shape, Timur realized that his creation could help many like him, who sought a simple yet effective way to elevate their daily routine. He pictured a community of users sharing their experiences, encouraging each other, and thriving together. With each iteration, the app became more intuitive, learning and adapting to provide a tailored contrast shower journey for every user.

Now, with the Contrast Shower Companion in hand, anyone could embark on this transformative journey. Timur's app was more than just a tool; it was a personal wellness coach, a historian, and a gateway to a more vibrant life.


## Assignment Requirements:


### Content and Design (5 points):

Design the main screen to display the user's shower session history and a button to begin a new session.
Create a detailed screen for active sessions, showing the current temperature phase and remaining time.

### Theme (2 points):

Craft a soothing and invigorating theme that captures the essence of the contrast shower experience.
Include visual cues that represent temperature changes (e.g., blue for cold, red for hot).

### Navigation (2 points):

Implement a simple flow that guides the user from the home screen to starting a shower session with minimal steps.
Provide clear visual back and exit options.

### Custom Render Object (3 points):

Design a custom animated widget that visually represents the transition between hot and cold phases of the shower.


## Classes and OOP Realization (2 points):

Model the logic using classes such as ShowerSession, TemperaturePhase, and UserPreferences. Use mixins,abstracts ans so on ...


## Riverpod State Management (3 points):

Utilize Riverpod for state management to handle user preferences, session states, and history.


### Points for Offline Storing History (3 point):

Use local storage, such as SharedPreferences or Hive, to persist the user's shower history.
Ensure that the app can retrieve and display the stored history even when offline.

### Evaluation:
The app will be evaluated for its practicality, ease of use, and the ability to enhance the contrast shower experience.
State management and data persistence will be key factors in assessing the project's robustness.
Timur's vision is now in your hands. Create an app that brings the contrast shower experience to life and helps users like Timur turn a simple routine into a journey of well-being.


## Requirements: 

### User Flow in the Contrast Shower Companion App

#### Starting a New Session:

**Home Screen:** Upon launching the app, users are greeted with a clean, tranquil home screen displaying their previous shower sessions. A prominent 'Start New Session' button is at the center of the screen. <br>
**Session Preferences:** Tapping the 'Start New Session' button leads to a preferences screen where users can customize the upcoming session's duration and temperature intervals.<br>
**Session Overview:** After setting their preferences, users are shown an overview of their upcoming session with a summary of intervals and total time. A 'Begin Session' button starts the shower timer.

#### During the Session:

**Active Session Screen:** As the session begins, the screen transitions to display a large, animated timer indicating the current phase (hot or cold) with corresponding color themes (red for hot, blue for cold).<br>
**Phase Transitions:** When it's time to switch temperatures, the app provides a clear visual cue through the custom render object animation and an optional sound notification.<br>
**Manual Override:** Users have the option to pause or end the session early via on-screen buttons, in cases where they need to adjust the session manually.

#### Post-Session:
**Session Summary:** At the end of the session, users are taken to a summary screen showing the total time, number of phases completed, and an option to rate their experience.<br>
**History Update:** The session details are automatically saved to the user's history, which can be viewed on the home screen.<br>
**Home Screen Update:** The user is then returned to the home screen, which now displays the most recent session at the top of the history list.