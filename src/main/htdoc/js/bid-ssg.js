/**
 * 신세계 전용 SaleCert Controller
 */
app.controller('saleCertSSGCtl', function($scope, consts, common, $interval, input, locale, $filter, $http) {
  $scope.sale = input.sale;
  $scope.parent = input.parent;
  $scope.sale_cert = $scope.parent.sale_cert;
  $scope.callBack = input.callBack;

  // [Event] 팝업 창 닫기
  $scope.close = function() {
    if ($scope.parent.refreshLots) {
      $scope.parent.refreshLots();
    }

    if ($scope.parent.runLotsRefresh) {
      $scope.parent.runLotsRefresh();
    }

    $scope.parent.modal.close();

    //브라우저가 닫히면 세션을 삭제
    if (($scope.parent.sale_cert.CNT || 0) <= 0) {
      setCookie('sale_cert_cancel', true);
    } else if ($scope.callBack) {
      $scope.callBack(input);
    }
  }

  let $e = function() {
    $scope.is_processing = false;
  }

  let $s = function(data, status) {
    $scope.is_processing = false;
  };

  let finalRefresh = function() {
    $scope.is_processing = false;
  }

  $scope.hp1s = ['010', '011', '016', '017', '018', '019'];

  // 폼 데이터 초기값
  $scope.form_data = {
    can_auth: false,
    auth_num: null,
    name: '',
    ph1: '',
    hp2: '',
    hp3: '',
    check1: false,
    check2: false,
  };

  $scope.auth_req_btn_txt = '인증번호요청';

  $scope.checkHpAuth = {
    valid: false,
    message: '',
    check: '',
  }

  // [Event] CheckAll
  $scope.checkboxAll = () => {
    if ($('#agreeCert_checkbox_all').prop('checked')) {
      $('input[name="agreeCert_checkbox"]').prop('checked', true);
    } else {
      $('input[name="agreeCert_checkbox"]').prop('checked', false);
    }
  }

  // [Event] 인증번호 전송
  $scope.authNumRequest = () => {
    let checkboxLength = $('input:checkbox[name="agreeCert_checkbox"]').length; // 체크박스 전체 개수
    let checkedLength = $('input:checkbox[name="agreeCert_checkbox"]:checked').length; // 체크된 개수

    // TODO: 체크박스 변경
    // TODO: 마케팅 수신 동의 저장

    // 전체 체크가 안되어 있으면, 취소
    if (checkboxLength !== checkedLength) {
      window.alert($scope.locale === 'ko' ? '약관에 모두 동의해주세요.' : 'Please agree to all the terms and conditions.');
      return;
    }

    if (!$scope.form_data.hp1 || !$scope.form_data.hp2 || !$scope.form_data.hp3) {
      window.alert('휴대폰 번호를 입력해주세요');
      return;
    }

    $scope.form_data.can_auth = false;
    $scope.form_data.auth_num = null;

    // 타이머 초기화
    $interval.cancel($scope.timer_duration);

    $scope.checkHpAuth.message = '';
    $scope.form_data.hp = `${$scope.form_data.hp1}-${$scope.form_data.hp2}-${$scope.form_data.hp3}`;

    const requestData = {
      to_phone: $scope.form_data.hp,
    };

    // 인증번호 전송 API Call
    common.callAPI('/join/send_auth_num', requestData, function(data, status) {
      console.log(`data: ${data}`);
      try {
        $scope.form_data.can_auth = true;
        $scope.auth_num_send_status = data.SEND_STATUS;
        $scope.auth_end_time = moment(new Date()).add(120, 'seconds');

        if ($scope.auth_num_send_status) {
          $scope.timer_duration = $interval($scope.setAuthDuration, 1000);
          console.log("======> set timer");
        }
        $scope.auth_req_btn_txt = '인증번호 재요청';
      } catch(err) {
        $scope.auth_num_send_status = false;
      }
    });
  }

  // [Event] 인증하기 버튼 클릭
  $scope.authNumConfirmSSG = () => {
    const savedPhoneNumber = $scope.sale_cert.HP;
    const savedPhoneNumberNoHyphen = savedPhoneNumber.replace(/[^\d]/g, '');
    const formData = $scope.form_data;

    // 이름 입력 체크
    if (!formData.name) {
      window.alert('이름을 입력해주세요');
      return;
    }

    // 인증 번호 체크
    if (!formData.auth_num) {
      $scope.checkHpAuth.message = '인증번호를 넣으세요.';
      return;
    }

    // 다시 한번 Set
    $scope.form_data.hp = `${$scope.form_data.hp1}-${$scope.form_data.hp2}-${$scope.form_data.hp3}`;

    const phoneNumberNumberOnly = $scope.form_data.hp.replace(/[^\d]/g, '');
    const isSamePhone = savedPhoneNumberNoHyphen === phoneNumberNumberOnly;

    // Auth Request Data
    const reqData = {
      sale_no: $scope.sale.SALE_NO,
      hp: $scope.form_data.hp,
      done_cd: isSamePhone ? 'no_modify' : 'un_modify',
      auth_num: $scope.form_data.auth_num,
    }

    // 인증번호 확인 API Call
    common.callAPI('/join/confirm_auth_num4sale', reqData, function response(data, httpStatus) {

      // 인증 실패 -> 종료
      if (typeof data.resultCode === 'undefined' || Number(data.resultCode) !== 0) {
        $scope.checkHpAuth.message = '인증에 실패 하였습니다. 다시 요청 하세요.';
        $scope.checkHpAuth.check = '';
        $scope.checkHpAuth.valid = data;
        return;
      }

      // 인증된 번호가 아닐 경우, 핸드폰을 변경
      if (!isSamePhone) {
        const confirms = window.confirm('고객정보의 핸드폰번호와 일치하지 않습니다.\n인증받은 핸드폰번호로 갱신하시겠습니까?');
        if (confirms) {
          updatePhoneNumber($scope.form_data.hp, $scope.form_data.hp, () => {
            updateUserName(formData.name, () => {
              $scope.checkHpAuth.message = '인증에 성공 하였습니다.';
              $scope.checkHpAuth.check = 'ok';
              $scope.parent.sale_cert.CNT = 1;
            }, () => {}, $scope.close);
          }, () => {}, $scope.close);
          return;
        }
      }

      // 아니면 이름만 변경
      updateUserName(formData.name, () => {
        $scope.checkHpAuth.message = '인증에 성공 하였습니다.';
        $scope.checkHpAuth.check = 'ok';
        $scope.parent.sale_cert.CNT = 1;
      }, () => {}, $scope.close);
    }, function error() {
      $interval.cancel($scope.timer_duration);
      console.log("======> cancel timer");
      $scope.form_data.auth_num = null;
    }, $scope.close);
  }

  // [Action] 이릅 업데이트
  function updateUserName(name, callback) {
    common.callAPI('/auth/update/name', { name: name }, (data, httpStatus) => {
      return callback(data, httpStatus);
    });
  }

  // [Action] 폰번호 갱신
  function updatePhoneNumber(phoneNo, saleCertNo, callback) {
    const updatePhoneNumberData = {
      actionList: [
        {
          actionID: 'sale_cert_hp_mod',
          actionType: 'update',
          tableName: 'CERT',
          parmsList: [{ hp: phoneNo, sale_cert_no: saleCertNo }]
        }
      ]
    }

    common.callActionSet(updatePhoneNumberData, (data, httpStatus) => {
      return callback(data, httpStatus);
    });
  }

  // [Event] 핸드폰 인증 메시지 변경
  $scope.getHpAuthMsg = function() {
    return $scope.checkHpAuth.message;
  }

  // 타이머 구현 로직
  $scope.setAuthDuration = function() {
    const format = 'm:s';
    const diffSeconds = moment($scope.auth_end_time).diff(moment(new Date()), 'seconds'); // 남은 초

    if (diffSeconds > 0) {
      $scope.checkHpAuth.message = "남은시간 : " + moment.duration(diffSeconds, "seconds").format(format);
    } else if (diffSeconds === 0) {
      $scope.form_data.can_auth = false;
      $scope.checkHpAuth.message = '0';
      $interval.cancel($scope.timer_duration);
      console.log('======> cancel timer');

      // 인증 만료 요청
      common.callAPI('/join/clear_auth_num', {}, function(){
        $scope.checkHpAuth.message = "인증 시간이 초과되었습니다. 다시 요청 하세요.";
      });
    }
  }
});
