interface StudyTask {
  id: number;
  title: string;
  done: boolean;
}

interface LicenseOption {
  name: string;
  scene: string;
  tip: string;
  color: string;
}

@Entry
@Component
struct Index {
  @State activeTab: number = 0;
  @State newTask: string = '';
  @State selectedLicense: string = 'MIT';
  @State tasks: StudyTask[] = [
    { id: 1, title: '确定项目主题与 README 结构', done: true },
    { id: 2, title: '阅读 MIT / Apache-2.0 / GPL-3.0 协议差异', done: false },
    { id: 3, title: '为课程大作业准备一次 Git 提交记录', done: false },
    { id: 4, title: '检查 issues、PR、commit message 是否清晰', done: false }
  ];

  private tabs: string[] = ['总览', '待办', '许可证', '贡献'];
  private licenseOptions: LicenseOption[] = [
    {
      name: 'MIT',
      scene: '希望代码被尽可能自由地复用，作业、工具、小型应用都适合。',
      tip: '保留版权声明和许可文本即可，限制最少。',
      color: '#2F6BFF'
    },
    {
      name: 'Apache-2.0',
      scene: '希望明确专利授权，并对企业或团队协作更友好。',
      tip: '需要保留 NOTICE，并说明重要修改。',
      color: '#7C3AED'
    },
    {
      name: 'GPL-3.0',
      scene: '希望衍生作品也继续开源，强调共享与传染性开源。',
      tip: '分发修改版时通常需要继续以 GPL 开源。',
      color: '#E67E22'
    }
  ];

  private getDoneCount(): number {
    return this.tasks.filter((item: StudyTask) => item.done).length;
  }

  private getProgressPercent(): number {
    if (this.tasks.length === 0) {
      return 0;
    }
    return Math.round(this.getDoneCount() * 100 / this.tasks.length);
  }

  private addTask(): void {
    const title = this.newTask.trim();
    if (title.length === 0) {
      return;
    }
    this.tasks = [{ id: Date.now(), title: title, done: false }, ...this.tasks];
    this.newTask = '';
  }

  private toggleTask(id: number): void {
    this.tasks = this.tasks.map((item: StudyTask) => {
      if (item.id === id) {
        return { id: item.id, title: item.title, done: !item.done };
      }
      return item;
    });
  }

  private removeTask(id: number): void {
    this.tasks = this.tasks.filter((item: StudyTask) => item.id !== id);
  }

  build() {
    Column() {
      this.Header()
      this.TabBar()
      Column() {
        if (this.activeTab === 0) {
          this.OverviewPage()
        } else if (this.activeTab === 1) {
          this.TasksPage()
        } else if (this.activeTab === 2) {
          this.LicensePage()
        } else {
          this.ContributionPage()
        }
      }
      .layoutWeight(1)
      .width('100%')
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#F5F7FB')
  }

  @Builder
  Header() {
    Column() {
      Row() {
        Column() {
          Text('开源学习助手')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
          Text('用一个 HarmonyOS 小应用记录开源课程学习进度')
            .fontSize(14)
            .fontColor('#E8EEFF')
            .margin({ top: 8 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text(this.getProgressPercent().toString() + '%')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2F6BFF')
          .height(70)
          .width(70)
          .textAlign(TextAlign.Center)
          .backgroundColor(Color.White)
          .borderRadius(35)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 54, bottom: 26 })
    .backgroundColor('#2F6BFF')
    .borderRadius({ bottomLeft: 28, bottomRight: 28 })
  }

  @Builder
  TabBar() {
    Row() {
      ForEach(this.tabs, (item: string, index: number) => {
        Text(item)
          .fontSize(15)
          .fontWeight(this.activeTab === index ? FontWeight.Bold : FontWeight.Normal)
          .fontColor(this.activeTab === index ? Color.White : '#334155')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
          .height(42)
          .backgroundColor(this.activeTab === index ? '#2F6BFF' : Color.Transparent)
          .borderRadius(21)
          .onClick(() => {
            this.activeTab = index;
          })
      }, (item: string) => item)
    }
    .width('92%')
    .padding(4)
    .margin({ top: 16, bottom: 8 })
    .backgroundColor(Color.White)
    .borderRadius(25)
  }

  @Builder
  OverviewPage() {
    Scroll() {
      Column() {
        this.MetricCards()
        this.InfoCard('项目定位', '面向《开源软件开发技术》课程，聚合学习任务、许可证对比和贡献流程清单，帮助完成可展示的小型 HarmonyOS 应用。', '#2F6BFF')
        this.InfoCard('核心功能', '支持新增学习待办、完成/撤销任务、删除任务；同时提供常见开源许可证选择提示和贡献步骤说明。', '#19C37D')
        this.InfoCard('技术栈', '使用 DevEco Studio 创建 Stage 模型工程，界面由 ArkTS 与 ArkUI 声明式组件实现。', '#7C3AED')
      }
      .padding({ left: 20, right: 20, bottom: 24 })
      .width('100%')
    }
  }

  @Builder
  MetricCards() {
    Row() {
      this.MetricCard('任务数', this.tasks.length.toString(), '#2F6BFF')
      this.MetricCard('已完成', this.getDoneCount().toString(), '#19C37D')
      this.MetricCard('进度', this.getProgressPercent().toString() + '%', '#E67E22')
    }
    .width('100%')
    .margin({ top: 10, bottom: 14 })
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  MetricCard(label: string, value: string, color: string) {
    Column() {
      Text(value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(color)
      Text(label)
        .fontSize(13)
        .fontColor('#64748B')
        .margin({ top: 6 })
    }
    .width('31%')
    .padding({ top: 18, bottom: 18 })
    .backgroundColor(Color.White)
    .borderRadius(18)
  }

  @Builder
  InfoCard(title: string, content: string, accent: string) {
    Column() {
      Row() {
        Text('')
          .width(6)
          .height(24)
          .backgroundColor(accent)
          .borderRadius(3)
        Text(title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .margin({ left: 10 })
      }
      .width('100%')

      Text(content)
        .fontSize(15)
        .fontColor('#475569')
        .lineHeight(24)
        .margin({ top: 12 })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(18)
    .margin({ bottom: 14 })
    .backgroundColor(Color.White)
    .borderRadius(20)
  }

  @Builder
  TasksPage() {
    Scroll() {
      Column() {
        Row() {
          TextInput({ placeholder: '添加新的开源学习任务', text: this.newTask })
            .height(46)
            .layoutWeight(1)
            .backgroundColor(Color.White)
            .borderRadius(14)
            .onChange((value: string) => {
              this.newTask = value;
            })

          Button('添加')
            .height(46)
            .margin({ left: 10 })
            .backgroundColor('#2F6BFF')
            .borderRadius(14)
            .onClick(() => {
              this.addTask();
            })
        }
        .width('100%')
        .margin({ top: 12, bottom: 14 })

        ForEach(this.tasks, (task: StudyTask) => {
          this.TaskItem(task)
        }, (task: StudyTask) => task.id.toString())
      }
      .padding({ left: 20, right: 20, bottom: 24 })
      .width('100%')
    }
  }

  @Builder
  TaskItem(task: StudyTask) {
    Column() {
      Row() {
        Column() {
          Text(task.title)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(task.done ? '#94A3B8' : '#0F172A')
            .decoration({ type: task.done ? TextDecorationType.LineThrough : TextDecorationType.None })
          Text(task.done ? '已完成' : '进行中')
            .fontSize(12)
            .fontColor(task.done ? '#19C37D' : '#F59E0B')
            .margin({ top: 6 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Button(task.done ? '撤销' : '完成')
          .fontSize(13)
          .height(34)
          .backgroundColor(task.done ? '#CBD5E1' : '#19C37D')
          .borderRadius(17)
          .onClick(() => {
            this.toggleTask(task.id);
          })

        Button('删除')
          .fontSize(13)
          .height(34)
          .margin({ left: 8 })
          .backgroundColor('#EF4444')
          .borderRadius(17)
          .onClick(() => {
            this.removeTask(task.id);
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(16)
    .margin({ bottom: 12 })
    .backgroundColor(Color.White)
    .borderRadius(18)
  }

  @Builder
  LicensePage() {
    Scroll() {
      Column() {
        Text('选择适合项目的开源许可证')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .width('100%')
          .margin({ top: 14, bottom: 12 })

        ForEach(this.licenseOptions, (item: LicenseOption) => {
          this.LicenseCard(item)
        }, (item: LicenseOption) => item.name)
      }
      .padding({ left: 20, right: 20, bottom: 24 })
      .width('100%')
    }
  }

  @Builder
  LicenseCard(item: LicenseOption) {
    Column() {
      Row() {
        Text(item.name)
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.selectedLicense === item.name ? Color.White : item.color)
        Blank()
        Text(this.selectedLicense === item.name ? '已选择' : '点选')
          .fontSize(13)
          .fontColor(this.selectedLicense === item.name ? Color.White : '#64748B')
      }
      .width('100%')

      Text(item.scene)
        .fontSize(15)
        .lineHeight(23)
        .fontColor(this.selectedLicense === item.name ? '#EEF2FF' : '#475569')
        .margin({ top: 12 })
      Text(item.tip)
        .fontSize(13)
        .lineHeight(21)
        .fontColor(this.selectedLicense === item.name ? '#DBEAFE' : '#64748B')
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(18)
    .margin({ bottom: 14 })
    .backgroundColor(this.selectedLicense === item.name ? item.color : Color.White)
    .borderRadius(20)
    .onClick(() => {
      this.selectedLicense = item.name;
    })
  }

  @Builder
  ContributionPage() {
    Scroll() {
      Column() {
        this.StepItem('1', 'Fork / Clone', '从 GitHub 获取项目代码，确认 remote 地址与默认分支。')
        this.StepItem('2', 'Create Branch', '为每个功能建立独立分支，使用清晰的分支名。')
        this.StepItem('3', 'Commit', '提交信息描述“做了什么”和“为什么做”，避免一次提交混入无关内容。')
        this.StepItem('4', 'Pull Request', '在 PR 中写明背景、修改点、测试方式和截图。')
        this.StepItem('5', 'Review & Merge', '根据 review 意见修改，检查 CI 后再合并。')
      }
      .padding({ left: 20, right: 20, top: 12, bottom: 24 })
      .width('100%')
    }
  }

  @Builder
  StepItem(order: string, title: string, description: string) {
    Row() {
      Text(order)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .textAlign(TextAlign.Center)
        .width(44)
        .height(44)
        .backgroundColor('#2F6BFF')
        .borderRadius(22)

      Column() {
        Text(title)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
        Text(description)
          .fontSize(14)
          .fontColor('#475569')
          .lineHeight(22)
          .margin({ top: 6 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 14 })
    }
    .alignItems(VerticalAlign.Top)
    .width('100%')
    .padding(18)
    .margin({ bottom: 12 })
    .backgroundColor(Color.White)
    .borderRadius(18)
  }
}
