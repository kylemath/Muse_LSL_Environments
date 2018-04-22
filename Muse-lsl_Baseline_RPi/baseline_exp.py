import time
import os
from random import randint
from random import shuffle
import datetime
import numpy
import pygame
from pylsl import StreamInfo, StreamOutlet, local_clock

###create our stream variables###
info = StreamInfo('Markers', 'Markers', 1, 0, 'int32', 'myuidw43536')

###next make an outlet to record the streamed data###
outlet = StreamOutlet(info)

###setup GPIO pins and initialise pygame###
pygame.mixer.pre_init(44100,-16,2,512)
pygame.init()
pygame.display.init()
pygame.mixer.init()

###setup the display screen and fixation###
pygame.mouse.set_visible(0)
disp_info = pygame.display.Info()
screen = pygame.display.set_mode((disp_info.current_w, disp_info.current_h),pygame.FULLSCREEN)
x_center = disp_info.current_w/2
y_center = disp_info.current_h/2

###FOR DEBUG###
#screen = pygame.display.set_mode((200,100),pygame.FULLSCREEN)
#x_center = 200/2
#y_center = 100/2
#####

black = pygame.Color(0, 0, 0)
white = pygame.Color(255,255,255)
pygame.mixer.music.load('/home/pi/Experiments/Baseline/high_tone.wav')

##### Define variables #####
partnum = "001"
#stop_eeg = [0]
#numpy.savetxt("/home/pi/Experiments/Baseline/Stop_EEG.csv", (stop_eeg), delimiter=',',fmt="%s")

###setup variables to record times###
vid_time 	= []
trig_time 	= []
trig_type	= []
delay_length 	= []

###define some other variables###
time_exp = 180

###setup our initial instruction screens###
pygame.font.init()
myfont = pygame.font.SysFont('Times New Roman', 20)
instructions_1 = myfont.render('For this experiment you will perform four, three-minute segments with either your eyes open or closed.', True, white)
instructions_2 = myfont.render('For the first part of the experiment you will keep your eyes open and focus on the above fixation cross.', True, white)
instructions_3 = myfont.render('You CAN blink during this time. Press the space bar when you are ready to begin.', True, white)

###instructions for the eyes-closed condition###
open_complete_1 = myfont.render('Great! You have completed a three-minute segment!',True,white)
open_complete_2 = myfont.render('For the next segment, you will keep your eyes closed for three minutes.',True,white)
open_complete_3 = myfont.render('Open your eyes when you hear a series of quick beeps through the headphones.',True,white)
open_complete_4 = myfont.render('Press the space bar when you are ready to begin.',True,white)
open_complete_5 = myfont.render('Please keep your eyes closed during this time.',True,white)

###instructions for the eyes-open condition###
closed_complete_1 = myfont.render('Great! You have completed a three-minute segment!',True,white)
closed_complete_2 = myfont.render('For the next segment, you will kepp your eyes open and focus on the fixation.',True,white)
closed_complete_3 = myfont.render('You CAN blink during this time. Press the space bar when you are ready.',True,white)

###completion instructions###
exp_complete_1 = myfont.render('Great! You have completed this experiment!',True,white)
exp_complete_2 = myfont.render('Please inform the experimenter you have finished.',True,white)

###show our instructions, and wait for a response###
pygame.draw.line(screen, (255, 255, 255), (x_center-10, y_center), (x_center+10, y_center),4)
pygame.draw.line(screen, (255, 255, 255), (x_center, y_center-10), (x_center, y_center+10),4)
screen.blit(instructions_1,(x_center-((instructions_1.get_rect().width)/2),y_center + ((instructions_1.get_rect().height)*1)+10))
screen.blit(instructions_2,(x_center-((instructions_2.get_rect().width)/2),y_center + ((instructions_2.get_rect().height)*2)+10))
screen.blit(instructions_3,(x_center-((instructions_3.get_rect().width)/2),y_center + ((instructions_3.get_rect().height)*3)+10))
pygame.display.flip()
key_pressed = 0
pygame.event.clear()
while key_pressed == 0:
    event = pygame.event.wait()
    if event.type == pygame.QUIT:
        pygame.quit()
        sys.exit()
    elif event.type == pygame.KEYDOWN:
        if event.key == pygame.K_SPACE:
            key_pressed = 1

###now let's present our fixation cross and begin the first 'eyes-open' condition###
###send triggers###
timestamp = local_clock()
outlet.push_sample([11], timestamp)
screen.fill(pygame.Color("black")) 
pygame.draw.line(screen, (255, 255, 255), (x_center-10, y_center), (x_center+10, y_center),4)
pygame.draw.line(screen, (255, 255, 255), (x_center, y_center-10), (x_center, y_center+10),4)
pygame.display.flip()
time.sleep(time_exp)

###now display instructions for the 'eyes-closed' condition###
###send triggers###
timestamp = local_clock()
outlet.push_sample([10], timestamp)
screen.blit(open_complete_1,(x_center-((open_complete_1.get_rect().width)/2),y_center + ((open_complete_1.get_rect().height)*1)+10))
screen.blit(open_complete_2,(x_center-((open_complete_2.get_rect().width)/2),y_center + ((open_complete_2.get_rect().height)*2)+10))
screen.blit(open_complete_3,(x_center-((open_complete_3.get_rect().width)/2),y_center + ((open_complete_3.get_rect().height)*3)+10))
screen.blit(open_complete_4,(x_center-((open_complete_4.get_rect().width)/2),y_center + ((open_complete_4.get_rect().height)*4)+10))
pygame.display.flip()
key_pressed = 0
pygame.event.clear()
while key_pressed == 0:
    event = pygame.event.wait()
    if event.type == pygame.QUIT:
        pygame.quit()
        sys.exit()
    elif event.type == pygame.KEYDOWN:
        if event.key == pygame.K_SPACE:
            key_pressed = 1

###remove the fixation cross and begin the 'eyes-closed' condition###
###send triggers###
timestamp = local_clock()
outlet.push_sample([21], timestamp)
screen.fill(pygame.Color("black"))
screen.blit(open_complete_5,(x_center-((open_complete_5.get_rect().width)/2),y_center + ((open_complete_5.get_rect().height))))
pygame.display.flip()
time.sleep(time_exp)

###play tones to signal to the participant that the task is over###
###send triggers###
timestamp = local_clock()
outlet.push_sample([20], timestamp)
for i_tone in range(3):
    pygame.mixer.music.play()
    time.sleep(0.5)

###now clear the screen and present instructions again for the 'eyes-open' condition###
screen.fill(pygame.Color("black")) 
pygame.draw.line(screen, (255, 255, 255), (x_center-10, y_center), (x_center+10, y_center),4)
pygame.draw.line(screen, (255, 255, 255), (x_center, y_center-10), (x_center, y_center+10),4)
screen.blit(closed_complete_1,(x_center-((closed_complete_1.get_rect().width)/2),y_center + ((closed_complete_1.get_rect().height)*1)+10))
screen.blit(closed_complete_2,(x_center-((closed_complete_2.get_rect().width)/2),y_center + ((closed_complete_2.get_rect().height)*2)+10))
screen.blit(closed_complete_3,(x_center-((closed_complete_3.get_rect().width)/2),y_center + ((closed_complete_3.get_rect().height)*3)+10))
pygame.display.flip()
key_pressed = 0
pygame.event.clear()
while key_pressed == 0:
    event = pygame.event.wait()
    if event.type == pygame.QUIT:
        pygame.quit()
        sys.exit()
    elif event.type == pygame.KEYDOWN:
        if event.key == pygame.K_SPACE:
            key_pressed = 1

###begin the second 'eyes-open' condition###
###send triggers###
timestamp = local_clock()
outlet.push_sample([12], timestamp)
screen.fill(pygame.Color("black")) 
pygame.draw.line(screen, (255, 255, 255), (x_center-10, y_center), (x_center+10, y_center),4)
pygame.draw.line(screen, (255, 255, 255), (x_center, y_center-10), (x_center, y_center+10),4)
pygame.display.flip()
time.sleep(time_exp)

###now display instructions for the second 'eyes-closed' condition###
###send triggers###
timestamp = local_clock()
outlet.push_sample([10], timestamp)
screen.blit(open_complete_1,(x_center-((open_complete_1.get_rect().width)/2),y_center + ((open_complete_1.get_rect().height)*1)+10))
screen.blit(open_complete_2,(x_center-((open_complete_2.get_rect().width)/2),y_center + ((open_complete_2.get_rect().height)*2)+10))
screen.blit(open_complete_3,(x_center-((open_complete_3.get_rect().width)/2),y_center + ((open_complete_3.get_rect().height)*3)+10))
screen.blit(open_complete_4,(x_center-((open_complete_4.get_rect().width)/2),y_center + ((open_complete_4.get_rect().height)*4)+10))
pygame.display.flip()
key_pressed = 0
pygame.event.clear()
while key_pressed == 0:
    event = pygame.event.wait()
    if event.type == pygame.QUIT:
        pygame.quit()
        sys.exit()
    elif event.type == pygame.KEYDOWN:
        if event.key == pygame.K_SPACE:
            key_pressed = 1

###remove the fixation cross and begin the second 'eyes-closed' condition###
###send triggers###
timestamp = local_clock()
outlet.push_sample([22], timestamp)
screen.fill(pygame.Color("black"))
screen.blit(open_complete_5,(x_center-((open_complete_5.get_rect().width)/2),y_center + ((open_complete_5.get_rect().height))))
pygame.display.flip()
time.sleep(time_exp)

###play tones to signal to the participant that the task is over###
###send triggers###
timestamp = local_clock()
outlet.push_sample([20], timestamp)
for i_tone in range(3):
    pygame.mixer.music.play()
    time.sleep(0.5)

###tell participant experiment is finished###
screen.fill(pygame.Color("black"))
screen.blit(exp_complete_1,(x_center-((exp_complete_1.get_rect().width)/2),y_center + ((exp_complete_1.get_rect().height)*1)+10))
screen.blit(exp_complete_2,(x_center-((exp_complete_2.get_rect().width)/2),y_center + ((exp_complete_2.get_rect().height)*2)+10))
pygame.display.flip()
key_pressed = 0
pygame.event.clear()
while key_pressed == 0:
    event = pygame.event.wait()
    if event.type == pygame.QUIT:
        pygame.quit()
        sys.exit()
    elif event.type == pygame.KEYDOWN:
        if event.key == pygame.K_SPACE:
            key_pressed = 1

pygame.mouse.set_visible(0)

time.sleep(5)
os.remove("/home/pi/Experiments/Baseline/Stop_EEG.csv")
#stop_eeg = [1]
#numpy.savetxt("/home/pi/Experiments/Baseline/Stop_EEG.csv", (stop_eeg), delimiter=',',fmt="%s")

pygame.display.quit()
pygame.quit()	
