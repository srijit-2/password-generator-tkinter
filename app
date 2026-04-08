import tkinter as tk
import random
import string
from tkinter import messagebox


def generate_password():
    try:
        repeat = int(repeat_entry.get())
        length = int(length_entry.get())
    except:
        messagebox.showerror("Error", "Enter valid numbers")
        return

    if length <= 0:
        messagebox.showerror("Error", "Length must be > 0")
        return

    if repeat == 1 and length > len(character_string):
        messagebox.showerror("Error", "Length too long for no repetition")
        return

    if repeat == 1:
        password = random.sample(character_string, length)
    else:
        password = random.choices(character_string, k=length)

    password = ''.join(password)
    password_v.set(password)

    check_strength(password)



def check_strength(password):
    strength = 0

    if any(c.islower() for c in password):
        strength += 1
    if any(c.isupper() for c in password):
        strength += 1
    if any(c.isdigit() for c in password):
        strength += 1
    if any(c in string.punctuation for c in password):
        strength += 1

    if len(password) >= 12:
        strength += 1

    if strength <= 2:
        strength_label.config(text="Weak ", fg="red")
    elif strength == 3:
        strength_label.config(text="Medium ", fg="orange")
    else:
        strength_label.config(text="Strong ", fg="lime")



def copy_password():
    password = password_v.get()
    if password:
        root.clipboard_clear()
        root.clipboard_append(password)
        messagebox.showinfo("Copied", "Password copied to clipboard!")



root = tk.Tk()
root.title("Hacker Password Generator")
root.geometry("400x300")
root.config(bg="#0d1117") 

character_string = string.ascii_letters + string.digits + string.punctuation


title = tk.Label(root, text=" PASSWORD GENERATOR", 
                 font=("Courier", 16, "bold"), 
                 bg="#0d1117", fg="#00ffcc")
title.pack(pady=10)


frame = tk.Frame(root, bg="#0d1117")
frame.pack()

tk.Label(frame, text="Length:", bg="#0d1117", fg="white").grid(row=0, column=0, pady=5)
length_entry = tk.Entry(frame, width=5)
length_entry.grid(row=0, column=1)

tk.Label(frame, text="Repeat (1=No, 2=Yes):", bg="#0d1117", fg="white").grid(row=1, column=0, pady=5)
repeat_entry = tk.Entry(frame, width=5)
repeat_entry.grid(row=1, column=1)


password_v = tk.StringVar()

password_entry = tk.Entry(root, textvariable=password_v, 
                          font=("Courier", 12), 
                          bd=2, relief="solid", 
                          justify="center")
password_entry.pack(pady=10, ipadx=5, ipady=5)


btn_frame = tk.Frame(root, bg="#0d1117")
btn_frame.pack()

generate_btn = tk.Button(btn_frame, text="Generate", command=generate_password, bg="#238636", fg="white")
generate_btn.grid(row=0, column=0, padx=10)

copy_btn = tk.Button(btn_frame, text="Copy", command=copy_password, bg="#1f6feb", fg="white")
copy_btn.grid(row=0, column=1, padx=10)


strength_label = tk.Label(root, text="", bg="#0d1117", font=("Courier", 12))
strength_label.pack(pady=10)


root.mainloop()
