interface WallCell {
  x: number;
  y: number;
}

@Entry
@Component
struct Index {
  @State playerX: number = 4;
  @State playerY: number = 8;
  @State enemyX: number = 4;
  @State enemyY: number = 0;
  @State dirX: number = 0;
  @State dirY: number = -1;
  @State score: number = 0;
  @State life: number = 3;
  @State message: string = '????????????????';
  @State gameOver: boolean = false;

  private size: number = 9;
  private rows: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  private cols: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  private walls: WallCell[] = [
    { x: 2, y: 2 }, { x: 3, y: 2 }, { x: 6, y: 2 },
    { x: 1, y: 4 }, { x: 4, y: 4 }, { x: 7, y: 4 },
    { x: 2, y: 6 }, { x: 5, y: 6 }, { x: 6, y: 6 }
  ];

  private isInside(x: number, y: number): boolean {
    return x >= 0 && x < this.size && y >= 0 && y < this.size;
  }

  private isWall(x: number, y: number): boolean {
    for (let i = 0; i < this.walls.length; i++) {
      if (this.walls[i].x === x && this.walls[i].y === y) {
        return true;
      }
    }
    return false;
  }

  private movePlayer(dx: number, dy: number): void {
    if (this.gameOver) {
      return;
    }

    this.dirX = dx;
    this.dirY = dy;
    const nextX = this.playerX + dx;
    const nextY = this.playerY + dy;

    if (!this.isInside(nextX, nextY) || this.isWall(nextX, nextY)) {
      this.message = '??????????';
      return;
    }

    this.playerX = nextX;
    this.playerY = nextY;
    if (this.playerX === this.enemyX && this.playerY === this.enemyY) {
      this.hurtPlayer();
      return;
    }
    this.enemyMove();
  }

  private fire(): void {
    if (this.gameOver) {
      return;
    }

    let x = this.playerX + this.dirX;
    let y = this.playerY + this.dirY;
    while (this.isInside(x, y)) {
      if (this.isWall(x, y)) {
        this.message = '???????';
        this.enemyMove();
        return;
      }
      if (x === this.enemyX && y === this.enemyY) {
        this.score++;
        if (this.score >= 5) {
          this.gameOver = true;
          this.message = '??????? 5 ?';
        } else {
          this.message = '??????????';
          this.resetEnemy();
        }
        return;
      }
      x += this.dirX;
      y += this.dirY;
    }

    this.message = '????';
    this.enemyMove();
  }

  private enemyMove(): void {
    if (this.gameOver) {
      return;
    }

    let dx = 0;
    let dy = 0;
    if (Math.random() > 0.5) {
      dx = this.playerX > this.enemyX ? 1 : -1;
    } else {
      dy = this.playerY > this.enemyY ? 1 : -1;
    }

    const nextX = this.enemyX + dx;
    const nextY = this.enemyY + dy;
    if (this.isInside(nextX, nextY) && !this.isWall(nextX, nextY) && !(nextX === this.playerX && nextY === this.playerY)) {
      this.enemyX = nextX;
      this.enemyY = nextY;
    }

    if (Math.abs(this.enemyX - this.playerX) + Math.abs(this.enemyY - this.playerY) <= 1) {
      this.hurtPlayer();
    }
  }

  private hurtPlayer(): void {
    this.life--;
    if (this.life <= 0) {
      this.gameOver = true;
      this.message = '???????????';
    } else {
      this.message = '????????? -1';
      this.playerX = 4;
      this.playerY = 8;
      this.enemyX = 4;
      this.enemyY = 0;
    }
  }

  private resetEnemy(): void {
    const listX: number[] = [0, 8, 1, 7, 4];
    const listY: number[] = [0, 0, 7, 7, 1];
    const index = this.score % listX.length;
    this.enemyX = listX[index];
    this.enemyY = listY[index];
  }

  private restart(): void {
    this.playerX = 4;
    this.playerY = 8;
    this.enemyX = 4;
    this.enemyY = 0;
    this.dirX = 0;
    this.dirY = -1;
    this.score = 0;
    this.life = 3;
    this.gameOver = false;
    this.message = '?????';
  }

  private cellText(x: number, y: number): string {
    if (x === this.playerX && y === this.playerY) {
      return '?';
    }
    if (x === this.enemyX && y === this.enemyY) {
      return '?';
    }
    if (this.isWall(x, y)) {
      return '?';
    }
    return '';
  }

  private cellColor(x: number, y: number): string {
    if (x === this.playerX && y === this.playerY) {
      return '#3CB371';
    }
    if (x === this.enemyX && y === this.enemyY) {
      return '#E74C3C';
    }
    if (this.isWall(x, y)) {
      return '#666666';
    }
    return '#F2F2F2';
  }

  private faceText(): string {
    if (this.dirX === 0 && this.dirY === -1) {
      return '?';
    }
    if (this.dirX === 0 && this.dirY === 1) {
      return '?';
    }
    if (this.dirX === -1 && this.dirY === 0) {
      return '?';
    }
    return '?';
  }

  build() {
    Column() {
      Text('????')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor('#222222')
        .margin({ top: 35, bottom: 8 })

      Text('??? ArkTS ???????')
        .fontSize(14)
        .fontColor('#666666')
        .margin({ bottom: 16 })

      Row() {
        this.InfoBox('??', this.score.toString())
        this.InfoBox('??', this.life.toString())
        this.InfoBox('??', this.faceText())
      }
      .justifyContent(FlexAlign.SpaceAround)
      .width('92%')
      .margin({ bottom: 14 })

      this.GameMap()

      Text(this.message)
        .fontSize(15)
        .fontColor(this.gameOver ? '#D35400' : '#333333')
        .textAlign(TextAlign.Center)
        .width('90%')
        .height(42)
        .margin({ top: 12, bottom: 8 })

      this.ControlButtons()

      Button('????')
        .width(150)
        .height(42)
        .fontSize(16)
        .backgroundColor('#444444')
        .margin({ top: 14 })
        .onClick(() => {
          this.restart();
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FAFAFA')
  }

  @Builder
  InfoBox(name: string, value: string) {
    Column() {
      Text(value)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1F4E79')
      Text(name)
        .fontSize(13)
        .fontColor('#666666')
    }
    .width('28%')
    .height(62)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.White)
    .borderRadius(10)
    .border({ width: 1, color: '#DDDDDD' })
  }

  @Builder
  GameMap() {
    Column() {
      ForEach(this.rows, (row: number) => {
        Row() {
          ForEach(this.cols, (col: number) => {
            this.Cell(col, row)
          }, (col: number) => col.toString())
        }
      }, (row: number) => row.toString())
    }
    .padding(8)
    .backgroundColor('#222222')
    .borderRadius(12)
  }

  @Builder
  Cell(x: number, y: number) {
    Text(this.cellText(x, y))
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor(Color.White)
      .textAlign(TextAlign.Center)
      .width(32)
      .height(32)
      .margin(2)
      .backgroundColor(this.cellColor(x, y))
      .borderRadius(4)
  }

  @Builder
  ControlButtons() {
    Column() {
      Button('?')
        .width(70)
        .height(42)
        .backgroundColor('#1F4E79')
        .onClick(() => {
          this.movePlayer(0, -1);
        })

      Row() {
        Button('?')
          .width(70)
          .height(42)
          .backgroundColor('#1F4E79')
          .onClick(() => {
            this.movePlayer(-1, 0);
          })
        Button('??')
          .width(90)
          .height(42)
          .backgroundColor('#D35400')
          .margin({ left: 10, right: 10 })
          .onClick(() => {
            this.fire();
          })
        Button('?')
          .width(70)
          .height(42)
          .backgroundColor('#1F4E79')
          .onClick(() => {
            this.movePlayer(1, 0);
          })
      }
      .margin({ top: 8, bottom: 8 })

      Button('?')
        .width(70)
        .height(42)
        .backgroundColor('#1F4E79')
        .onClick(() => {
          this.movePlayer(0, 1);
        })
    }
  }
}
