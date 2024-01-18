import pyautogui
import webbrowser

webbrowser.open('https://chat.openai.com')

pyautogui.sleep(5)

pyautogui.keyDown("ctrl")
pyautogui.press("v")
pyautogui.keyUp("ctrl")
# pyautogui.press("return")

