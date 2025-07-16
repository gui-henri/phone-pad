const canvas = document.getElementById('game-canvas');
const ctx = canvas.getContext('2d');
let ball = { x: 200, y: 100, r: 18, color: '#00ff99', vy: 0 };
const gravity = 0.9;
const wallWidth = 24;
const floor = canvas.height - ball.r;
const ceil = ball.r;

const areas = [
    { name: 'left', x: 215, y: 105, r: 20, dx: -24, dy: 0 },
    { name: 'right', x: 296, y: 102, r: 20, dx: 24, dy: 0 },
    { name: 'up', x: 255, y: 65, r: 20, dx: 0, dy: -24 },
    { name: 'down', x: 255, y: 137, r: 20, dx: 0, dy: 24 },
    { name: 'A', x: 465, y: 127, r: 35, dx: 32, dy: 0 },
    { name: 'B', x: 525, y: 73, r: 35, dx: 0, dy: -32 },
];

let moveLeft = false;
let moveRight = false;
let mouseDown = false;
let pressedAreas = {};
let androidColor = '#ffff22';

function randomColor() {
    return `hsl(${Math.floor(Math.random() * 360)}, 100%, 50%)`;
}

function handleArea(mx, my, isDown) {
    for (const area of areas) {
        const dist = Math.hypot(mx - area.x, my - area.y);
        if (dist < area.r) {
            pressedAreas[area.name] = isDown;
            if (area.name === 'left') {
                moveLeft = isDown;
            } else if (area.name === 'right') {
                moveRight = isDown;
            } else if ((area.name === 'B' || area.name === 'up' || area.name === 'A') && isDown && ball.y >= floor) {
                ball.vy = -18;
            } else if (area.name === 'down' && isDown) {
                androidColor = randomColor();
            }
            break;
        }
    }
}

// Carregar imagem do personagem
const androidImg = new Image();
androidImg.src = './assets/android.png';

function drawBall() {
    if (androidImg.complete) {
        ctx.save();
        ctx.imageSmoothingEnabled = false; // pixelado

        ctx.drawImage(androidImg, ball.x - ball.r, ball.y - ball.r, ball.r * 2, ball.r * 2);
        // Overlay de cor
        ctx.globalAlpha = 0.45;
        ctx.globalCompositeOperation = 'source-atop';
        ctx.fillStyle = androidColor;
        ctx.beginPath();
        ctx.arc(ball.x, ball.y, ball.r, 0, Math.PI * 2);
        ctx.fill();
        ctx.globalAlpha = 1.0;
        ctx.globalCompositeOperation = 'source-over';
        ctx.restore();
    } else {
        androidImg.onload = () => drawBall();
    }
}

function drawWalls() {
    ctx.fillStyle = '#991F00';
    ctx.fillRect(0, 0, wallWidth, canvas.height); // esquerda
    ctx.fillRect(canvas.width - wallWidth, 0, wallWidth, canvas.height); // direita

    ctx.strokeStyle = '#000';
    ctx.lineWidth = 4;
    ctx.strokeRect(0, 0, wallWidth, canvas.height); // esquerda
    ctx.strokeRect(canvas.width - wallWidth, 0, wallWidth, canvas.height); // direita
}

function drawAreas() {
    for (const area of areas) {
        ctx.beginPath();
        ctx.arc(area.x, area.y, area.r, 0, Math.PI * 2);
        ctx.strokeStyle = 'rgba(0,255,0,0.7)';
        ctx.lineWidth = 2;
        ctx.stroke();
    }
}

function drawPressedAreas() {
    for (const area of areas) {
        if (pressedAreas[area.name]) {
            ctx.save();
            ctx.globalAlpha = 0.35;
            ctx.beginPath();
            ctx.arc(area.x, area.y, area.r, 0, Math.PI * 2);
            ctx.fillStyle = '#111';
            ctx.fill();
            ctx.restore();
        }
    }
}

function draw() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    drawWalls();
    drawBall();
    drawPressedAreas();
}

function update() {
    // gravidade
    ball.vy += gravity;
    ball.y += ball.vy;
    // movimento contínuo
    if (moveLeft) {
        ball.x = Math.max(wallWidth + ball.r, ball.x - 4);
    }
    if (moveRight) {
        ball.x = Math.min(canvas.width - wallWidth - ball.r, ball.x + 4);
    }
    // colisão com chão
    if (ball.y > floor) {
        ball.y = floor;
        ball.vy = 0;
    }
    // colisão com teto
    if (ball.y < ceil) {
        ball.y = ceil;
        ball.vy = 0;
    }
    // colisão com paredes
    if (ball.x - ball.r < wallWidth) {
        ball.x = wallWidth + ball.r;
    }
    if (ball.x + ball.r > canvas.width - wallWidth) {
        ball.x = canvas.width - wallWidth - ball.r;
    }
}

function loop() {
    update();
    draw();
    requestAnimationFrame(loop);
}
loop();

canvas.addEventListener('mousedown', function (e) {
    mouseDown = true;
    const rect = canvas.getBoundingClientRect();
    const mx = e.clientX - rect.left;
    const my = e.clientY - rect.top;
    handleArea(mx, my, true);
});

canvas.addEventListener('mousemove', function (e) {
    if (!mouseDown) return;
    if (moveLeft || moveRight) return;
    const rect = canvas.getBoundingClientRect();
    const mx = e.clientX - rect.left;
    const my = e.clientY - rect.top;
    handleArea(mx, my, true);
});

document.addEventListener('mouseup', function () {
    mouseDown = false;
    moveLeft = false;
    moveRight = false;
    pressedAreas = {};
});

// Suporte a touch
canvas.addEventListener('touchstart', function (e) {
    mouseDown = true;
    const rect = canvas.getBoundingClientRect();
    const touch = e.touches[0];
    const mx = touch.clientX - rect.left;
    const my = touch.clientY - rect.top;
    handleArea(mx, my, true);
});
canvas.addEventListener('touchmove', function (e) {
    if (!mouseDown) return;
    if (moveLeft || moveRight) return;
    const rect = canvas.getBoundingClientRect();
    const touch = e.touches[0];
    const mx = touch.clientX - rect.left;
    const my = touch.clientY - rect.top;
    handleArea(mx, my, true);
});
document.addEventListener('touchend', function () {
    mouseDown = false;
    moveLeft = false;
    moveRight = false;
    pressedAreas = {};
});
