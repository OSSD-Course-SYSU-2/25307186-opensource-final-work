import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'OpenSourceStudyAssistant', 'EntryAbility onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'OpenSourceStudyAssistant', 'EntryAbility onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'OpenSourceStudyAssistant', 'Failed to load page: %{public}s', JSON.stringify(err));
        return;
      }
      hilog.info(0x0000, 'OpenSourceStudyAssistant', 'Page loaded');
    });
  }

  onWindowStageDestroy(): void {
    hilog.info(0x0000, 'OpenSourceStudyAssistant', 'WindowStage destroyed');
  }

  onForeground(): void {
    hilog.info(0x0000, 'OpenSourceStudyAssistant', 'Ability onForeground');
  }

  onBackground(): void {
    hilog.info(0x0000, 'OpenSourceStudyAssistant', 'Ability onBackground');
  }
}
