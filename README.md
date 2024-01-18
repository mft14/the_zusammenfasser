# The Zusammenfasser (the summarisor)

### TL;DR
The Zusammenfasser is a simple powershell script, that can summarize an article from certain websites using ChatGPT. You only need a free account and pass the URL into the script.


### Requirements
Attention: This program is still under development and not optimized for all systems.
The development was made in Linux, therefore it couldn't run properly on Windows yet

In order to use, you need:
- A free ChatGPT account
- Python3 installed
    - pyautogui library installed

You can download Python3 on the official website. 
Once Python is installed, you can run 
`pip3 install pyautogui`
for additional packages, that is required to automate the process.

### How to use
Make sure, you log in first into ChatGPT on your main browser and stay logged in.
Check then if [ChatGPT](https://chat.openai.com) opens automatically on a new chat.
If that's the case, then you can continue!

- Open the script in Powershell by typing pwsh the_zusammenfasser.ps1
- Choose Option 1 and pass in a news article from an approved website.
- It will then ask you to summarize it as short as possible (option 1), a general summary (option 2) or no summary at all and paste the text into a text file (option 3).

If you choose Option 1 and 2, you don't have to do anything. The python script will now open ChatGPT and waits three seconds, then it triggers CTRL+V to paste the text and press Return immediately after. The new summary will be printed out. You then can decide what to do next.

### Try not to
If you click something after python tries to open ChatGPT and paste the text, you might change the window focus so better is not to touch anything (no exceptions yet that prevents this)










