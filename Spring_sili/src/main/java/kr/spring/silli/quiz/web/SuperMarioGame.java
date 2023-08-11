package kr.spring.silli.quiz.web;

import java.awt.*;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import javax.swing.*;

public class SuperMarioGame extends JFrame implements KeyListener {
    private static final int SCREEN_WIDTH = 800;
    private static final int SCREEN_HEIGHT = 600;
    private static final int MARIO_SIZE = 50;
    private static final int GROUND_HEIGHT = 50;
    private static final int GRAVITY = 2;
    private static final int JUMP_HEIGHT = 30;
    private static final int MOVE_SPEED = 5;

    private int marioX;
    private int marioY;
    private int velocityY;
    private boolean isJumping;
    private Rectangle goal;
    private Rectangle[] obstacles;

    public SuperMarioGame() {
        setTitle("Super Mario Game");
        setSize(SCREEN_WIDTH, SCREEN_HEIGHT);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setResizable(false);
        setLocationRelativeTo(null);

        marioX = 100;
        marioY = SCREEN_HEIGHT - GROUND_HEIGHT - MARIO_SIZE;
        velocityY = 0;
        isJumping = false;

        goal = new Rectangle(SCREEN_WIDTH - 100, SCREEN_HEIGHT - GROUND_HEIGHT - MARIO_SIZE, MARIO_SIZE, MARIO_SIZE);

        obstacles = new Rectangle[3];
        obstacles[0] = new Rectangle(300, SCREEN_HEIGHT - GROUND_HEIGHT - MARIO_SIZE - 100, 100, 100);
        obstacles[1] = new Rectangle(500, SCREEN_HEIGHT - GROUND_HEIGHT - MARIO_SIZE - 200, 50, 200);
        obstacles[2] = new Rectangle(700, SCREEN_HEIGHT - GROUND_HEIGHT - MARIO_SIZE - 150, 80, 150);

        addKeyListener(this);
        setFocusable(true);
        requestFocus();
    }

    @Override
    public void keyPressed(KeyEvent e) {
        int keyCode = e.getKeyCode();
        if (keyCode == KeyEvent.VK_LEFT) {
            marioX -= MOVE_SPEED;
        } else if (keyCode == KeyEvent.VK_RIGHT) {
            marioX += MOVE_SPEED;
        } else if (keyCode == KeyEvent.VK_SPACE && !isJumping) {
            jump();
        }

        checkCollision();
        repaint();
    }

    @Override
    public void keyTyped(KeyEvent e) {
    }

    @Override
    public void keyReleased(KeyEvent e) {
    }

    private void jump() {
        isJumping = true;
        velocityY = -JUMP_HEIGHT;

        new Thread(() -> {
            try {
                Thread.sleep(500);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

            isJumping = false;
        }).start();
    }

    private void checkCollision() {
        Rectangle marioBounds = new Rectangle(marioX, marioY, MARIO_SIZE, MARIO_SIZE);

        for (Rectangle obstacle : obstacles) {
            if (marioBounds.intersects(obstacle)) {
                gameOver();
                break;
            }
        }

        if (marioBounds.intersects(goal)) {
            gameWon();
        }
    }

    private void gameWon() {
        JOptionPane.showMessageDialog(this, "Congratulations! You won the game!", "Game Over", JOptionPane.INFORMATION_MESSAGE);
        System.exit(0);
    }

    private void gameOver() {
        JOptionPane.showMessageDialog(this, "Game Over! Try again.", "Game Over", JOptionPane.ERROR_MESSAGE);
        resetGame();
    }

    private void resetGame() {
        marioX = 100;
        marioY = SCREEN_HEIGHT - GROUND_HEIGHT - MARIO_SIZE;
    }

    private void update() {
        if (isJumping) {
            marioY += velocityY;
            velocityY += GRAVITY;

            if (marioY >= SCREEN_HEIGHT - GROUND_HEIGHT - MARIO_SIZE) {
                marioY = SCREEN_HEIGHT - GROUND_HEIGHT - MARIO_SIZE;
                isJumping = false;
            }
        }
    }

    @Override
    public void paint(Graphics g) {
        super.paint(g);

        g.setColor(Color.GREEN);
        g.fillRect(0, SCREEN_HEIGHT - GROUND_HEIGHT, SCREEN_WIDTH, GROUND_HEIGHT);

        g.setColor(Color.RED);
        g.fillRect(marioX, marioY, MARIO_SIZE, MARIO_SIZE);

        g.setColor(Color.BLUE);
        g.fillRect(goal.x, goal.y, goal.width, goal.height);

        g.setColor(Color.GRAY);
        for (Rectangle obstacle : obstacles) {
            g.fillRect(obstacle.x, obstacle.y, obstacle.width, obstacle.height);
        }

        Toolkit.getDefaultToolkit().sync();
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            SuperMarioGame game = new SuperMarioGame();
            game.setVisible(true);

            new Thread(() -> {
                while (true) {
                    game.update();
                    game.repaint();

                    try {
                        Thread.sleep(10);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            }).start();
        });
    }
}
