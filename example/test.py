# Example file showing a circle moving on screen
import pygame

class Ball:
    def __init__(self, circle_pos, ball_speed, delta_time):
        self.id = "ball_id"
        self.ball_pos = circle_pos
        self.ball_speed = ball_speed
        self.delta_time = delta_time

    def update(self):
        # update calls

        all_pressed_keys = pygame.key.get_pressed()
        
        if all_pressed_keys[pygame.K_w]:
            self.ball_pos.y -= self.ball_speed * self.delta_time
        if all_pressed_keys[pygame.K_s]:
            self.ball_pos.y += self.ball_speed * self.delta_time
        if all_pressed_keys[pygame.K_a]:
            self.ball_pos.x -= self.ball_speed * self.delta_time
        if all_pressed_keys[pygame.K_d]:
            self.ball_pos.x += self.ball_speed * self.delta_time
        

delta_time = 0
is_game_running = True

circle_size = 20
circle_color = "red"
screen_width = 1280
screen_height = 720

ball_speed = 1000


# pygame setup
pygame.init()

screen_surface_base = pygame.display.set_mode((screen_width, screen_height))

center_screen = pygame.Vector2(screen_surface_base.get_width() / 2, screen_surface_base.get_height() / 2)
circle_pos = center_screen
game_clock = pygame.time.Clock()

while is_game_running:
    # poll for events
    # pygame.QUIT event means the user clicked X to close your window
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            is_game_running = False

    # fill the screen with a color to wipe away anything from last frame
    screen_surface_base.fill("lightblue")
    pygame.draw.circle(screen_surface_base, circle_color, circle_pos, circle_size)

    all_pressed_keys = pygame.key.get_pressed()
    
    if all_pressed_keys[pygame.K_w]:
        circle_pos.y -= ball_speed * delta_time
    if all_pressed_keys[pygame.K_s]:
        circle_pos.y += ball_speed * delta_time
    if all_pressed_keys[pygame.K_a]:
        circle_pos.x -= ball_speed * delta_time
    if all_pressed_keys[pygame.K_d]:
        circle_pos.x += ball_speed * delta_time
    
    # flip() the display to put your work on screen
    pygame.display.flip()

    # limits FPS to 60
    # dt is delta time in seconds since last frame, used for framerate-
    # independent physics.
    delta_time = game_clock.tick(60) / 1000

pygame.quit()