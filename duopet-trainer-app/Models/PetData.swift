//
//  PetData.swift
//  duopet-trainer-app
//
//  Static data for emergency fixes, 7-day plans, and taboos
//

import Foundation

// MARK: - Emergency Data
struct EmergencyDataProvider {
    static let dogProblems: [EmergencyProblem] = [
        EmergencyProblem(
            id: "pee",
            title: "乱尿乱拉",
            icon: "drop.fill",
            color: .warning,
            steps: (
                doNow: "立刻打断：抓现行时，严厉说\"No\"或拍手，不要大喊大叫。",
                dontDo: "禁止动作：千万不要事后把它的鼻子按在尿里，也不要事后打骂（狗只有3秒因果记忆）。",
                consolidate: "1天巩固：彻底清理尿渍去味，饭后15分钟带到正确地点，拉对立刻给高价值零食疯狂夸奖！"
            )
        ),
        EmergencyProblem(
            id: "destroy",
            title: "拆家咬东西",
            icon: "house.fill",
            color: .danger,
            steps: (
                doNow: "转移目标：冷静拿走被咬物品，塞给它磨牙棒或专属玩具。",
                dontDo: "禁止动作：不要抢夺（它以为在玩拔河），不要追着跑。",
                consolidate: "1天巩固：出门前消耗体力（散步嗅闻），把鞋子电线收好，限制活动空间（笼养或围栏）。"
            )
        ),
        EmergencyProblem(
            id: "bark",
            title: "乱吠暴冲",
            icon: "speaker.slash.fill",
            color: .blue,
            steps: (
                doNow: "打断并转身：吠叫时立刻转身背对它，双手交叉，不给任何眼神交流。",
                dontDo: "禁止动作：不要跟着它大喊\"闭嘴\"（它以为你在和它一起叫）。",
                consolidate: "1天巩固：安静下来后立刻转身给零食。有人敲门时，提前让它去窝里并给奖励。"
            )
        ),
        EmergencyProblem(
            id: "jump",
            title: "激动扑人",
            icon: "arrow.up.circle.fill",
            color: .primary,
            steps: (
                doNow: "无视并转身：立刻侧身或转身，手缩起来，变成一根\"木头\"。",
                dontDo: "禁止动作：不要用手推它胸口（它以为在玩耍），不要大声叫。",
                consolidate: "1天巩固：必须等它四脚落地并安静坐下后，再摸它并给零食。"
            )
        ),
    ]
    
    static let catProblems: [EmergencyProblem] = [
        EmergencyProblem(
            id: "pee",
            title: "乱尿 (猫砂盆外)",
            icon: "drop.fill",
            color: .warning,
            steps: (
                doNow: "清理去味：用生物酶分解剂清理现场，不要用含氨水成分（类似尿味）。",
                dontDo: "禁止动作：不要打骂，不要喷水，猫乱尿大多是发情、闭尿或猫砂盆太脏。",
                consolidate: "1天巩固：增加猫砂盆（猫数+1），每天铲屎2次，观察是否有泌尿疾病。"
            )
        ),
        EmergencyProblem(
            id: "scratch",
            title: "抓沙发/家具",
            icon: "scissors",
            color: .danger,
            steps: (
                doNow: "立刻贴膜：在被抓处贴双面胶或防抓贴，并在旁边放个更好的猫抓板。",
                dontDo: "禁止动作：不要强行抓着猫爪子去挠破坏处，不要事后指责。",
                consolidate: "1天巩固：在猫抓板上撒猫薄荷，定期修剪指甲。"
            )
        ),
        EmergencyProblem(
            id: "bite",
            title: "咬手/抱腿咬",
            icon: "bolt.fill",
            color: .blue,
            steps: (
                doNow: "立刻定住：停止所有动作，发出\"嘶\"的痛呼，等它松口后立刻走开。",
                dontDo: "禁止动作：不要拿手逗猫玩，不要甩手（激发捕猎本能）。",
                consolidate: "1天巩固：每天用逗猫棒消耗它的体力15分钟，满足捕猎需求。"
            )
        ),
        EmergencyProblem(
            id: "meow",
            title: "夜间跑酷乱叫",
            icon: "moon.fill",
            color: .primary,
            steps: (
                doNow: "彻底无视：闭上眼睛装睡，不要起身，不要安慰，不要给零食。",
                dontDo: "禁止动作：不要起床喂食，否则它会明白\"叫=有吃的\"。",
                consolidate: "1天巩固：睡前半小时高强度逗猫棒玩耍，玩累后喂一顿丰盛的罐头。"
            )
        ),
    ]
    
    static func problems(for type: PetType) -> [EmergencyProblem] {
        switch type {
        case .dog: return dogProblems
        case .cat: return catProblems
        }
    }
}

// MARK: - Plan Data
struct PlanDataProvider {
    static let dogPlan: [PlanDay] = [
        PlanDay(day: 1, title: "建立\"Yes\"连接", desc: "让狗狗知道：听到\"Yes\"（或点击器）= 有好吃的", tips: "准备一把碎零食。说\"Yes\"，立刻给零食。重复20次。不需要它做任何动作。", duration: "3分钟"),
        PlanDay(day: 2, title: "名字唤回", desc: "听到名字就必须转头看向你", tips: "无干扰环境，叫它名字。只要它看你，立刻\"Yes\"并给零食。不要连续重复叫。", duration: "5分钟"),
        PlanDay(day: 3, title: "坐下 (无口令)", desc: "用零食引导出坐下动作", tips: "零食放狗鼻尖上，慢慢往头顶后方移动。狗为了看吃的一定会屁股着地。着地瞬间\"Yes\"+给零食。", duration: "5分钟"),
        PlanDay(day: 4, title: "坐下 (加口令)", desc: "把动作与口令结合", tips: "说\"坐\"，做第3天的引导动作。坐下给零食。慢慢减少手的引导幅度。", duration: "5分钟"),
        PlanDay(day: 5, title: "放开 (脱敏)", desc: "学会松口，避免互咬", tips: "玩玩具时，拿更好吃的零食放鼻孔前说\"吐/Drop\"。松口咬零食时，拿走玩具。然后把玩具还它。", duration: "5分钟"),
        PlanDay(day: 6, title: "随行不暴冲", desc: "让它知道在你脚边才有好事", tips: "室内带牵引绳，绳子松弛时才走。绳子绷紧立马停下。它回头看你并靠近让绳子松了，给零食再走。", duration: "5分钟"),
        PlanDay(day: 7, title: "等待 (Wait)", desc: "吃饭/出门前的强制冷静", tips: "准备饭盆往下放。它一激动扑上来，饭盆立刻收回。直到它安静坐下，饭盆放下，说\"Wait\"，等3秒，说\"Ok\"开吃。", duration: "5分钟"),
    ]
    
    static let catPlan: [PlanDay] = [
        PlanDay(day: 1, title: "适应响片/Yes", desc: "建立奖励信号连接", tips: "用猫条或冻干。按响片或说\"滴\"，立刻给一点吃。重复15次。", duration: "3分钟"),
        PlanDay(day: 2, title: "名字反应", desc: "叫名字有回应", tips: "饭前进行。叫猫名字，只要看过来就\"滴\"+奖励。", duration: "3分钟"),
        PlanDay(day: 3, title: "手指引导", desc: "让猫跟着你的手指移动", tips: "手指抹一点肉泥，引诱它跟着走两步。熟练后只伸空手指，碰触手指就奖励。", duration: "5分钟"),
        PlanDay(day: 4, title: "坐下", desc: "猫也能学会坐", tips: "零食放鼻尖，慢慢往耳朵后方移。屁股着地瞬间\"滴\"+奖励。", duration: "5分钟"),
        PlanDay(day: 5, title: "击掌 (High Five)", desc: "趣味互动", tips: "握住零食在它头顶上方。它试图用爪子扒拉你手时，手掌摊开迎上去，碰爪瞬间\"滴\"+奖励。", duration: "5分钟"),
        PlanDay(day: 6, title: "回笼适应", desc: "不再害怕航空箱", tips: "把航空箱门拆掉，里面放最软的垫子和最爱的零食/猫薄荷。让它自由进出，绝不强行塞。", duration: "5分钟"),
        PlanDay(day: 7, title: "摸爪脱敏", desc: "为剪指甲做准备", tips: "在猫极度放松（困了）时，轻轻碰一下爪子，不抽回就给奖励。慢慢增加捏肉垫的力度。", duration: "5分钟"),
    ]
    
    static func plan(for type: PetType) -> [PlanDay] {
        switch type {
        case .dog: return dogPlan
        case .cat: return catPlan
        }
    }
}

// MARK: - Taboo Data
struct TabooDataProvider {
    static let taboos: [TrainingTaboo] = [
        TrainingTaboo(title: "大声吼叫或打骂", reason: "引发强烈应激，导致猫狗产生防卫性攻击，你只会得到一只怕你并恨你的宠物。"),
        TrainingTaboo(title: "事后开\"批斗大会\"", reason: "动植物的因果关联记忆只有3秒。你把它拖到尿旁边骂，它只会觉得\"尿\"是一件恐怖的事，以后会偷偷躲起来尿。"),
        TrainingTaboo(title: "过度拉长时间", reason: "单次训练严禁超过10分钟。宠物注意力一旦涣散，强行训练会起反效果，甚至厌恶训练。"),
        TrainingTaboo(title: "错误时机给奖励", reason: "狗在狂叫，你为了安抚它给了零食。它脑中关联的是：\"狂叫 = 有零食\"，反而强化了恶习。"),
        TrainingTaboo(title: "全家没有统一标准", reason: "你教它不能上沙发，你妈却偷偷抱它上沙发。这就造成指令混乱，无论你怎么练也没用。"),
    ]
}
