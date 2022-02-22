/**
 * 신세계 전용 SaleCert Controller
 */
app.controller('saleCertSSGCtl', function($scope, consts, common, $interval, input, locale, $filter, _csrf, _csrf_header) {
  $scope.sale = input.sale;
  $scope.parent = input.parent;
  $scope.sale_cert = $scope.parent.sale_cert;
  $scope.callBack = input.callBack;

  // Initial Values
  $scope.hp1s = ['010', '011', '016', '017', '018', '019'];
  $scope.auth_req_btn_txt = '인증번호요청';

  // 폼 데이터 (model)
  $scope.form_data = {
    can_auth: false,
    auth_num: '',
    name: '',
    ph1: '',
    hp2: '',
    hp3: '',
    checkAgreePrivacy: false,
    checkAgreeMarketing: false,
    checkPolicy1: false,
    checkPolicy2: false,
    checkPolicy3: false,
    checkPolicy4: false,
    checkHpAuth: {
      valid: false,
      message: '',
      check: '',
    },
  };

  /**
   * [Event] 팝업 창 닫기 이벤트
   */
  $scope.close = function() {
    if (typeof $scope.parent.refreshLots === 'function') {
      $scope.parent.refreshLots();
    }

    if (typeof $scope.parent.runLotsRefresh === 'function') {
      $scope.parent.runLotsRefresh();
    }

    $scope.parent.modal.close();

    // 팝업이 닫히고 세션을 삭제
    if (($scope.parent.sale_cert.CNT || 0) <= 0) {
      setCookie('sale_cert_cancel', true);
    } else if ($scope.callBack) {
      $scope.callBack(input);
    }
  }

  /**
   * [Event] Check All
   */
  $scope.checkboxAll = function(e) {
    const isCheckAll = e.currentTarget.checked;
    $scope.form_data.checkAgreePrivacy = isCheckAll;
    $scope.form_data.checkAgreeMarketing = isCheckAll;
    $scope.form_data.checkPolicy1 = isCheckAll;
    $scope.form_data.checkPolicy2 = isCheckAll;
    $scope.form_data.checkPolicy3 = isCheckAll;
    $scope.form_data.checkPolicy4 = isCheckAll;
  }


  /**
   * [Event] 인증번호 전송 클릭 이벤트
   */
  $scope.authNumRequest = function() {

    // 체크 여부
    const isRequiredChecked = 
      $scope.form_data.checkAgreePrivacy &&
      // $scope.form_data.checkAgreeMarketing &&
      $scope.form_data.checkPolicy1 &&
      $scope.form_data.checkPolicy2 &&
      $scope.form_data.checkPolicy3 &&
      $scope.form_data.checkPolicy4
    ;

    if (!isRequiredChecked) {
      window.alert($scope.locale === 'ko' ? '약관에 모두 동의해주세요.' : 'Please agree to all the terms and conditions.');
      return;
    }

    if (!$scope.form_data.hp1 || !$scope.form_data.hp2 || !$scope.form_data.hp3) {
      window.alert('휴대폰 번호를 입력해주세요');
      return;
    }

    // 기존 값 초기화
    $scope.form_data.can_auth = false;
    $scope.form_data.auth_num = null;

    // 타이머 초기화
    $interval.cancel($scope.timer_duration);

    // 에러 메시지 초기화
    $scope.form_data.checkHpAuth.message = '';
    $scope.form_data.hp = `${$scope.form_data.hp1}-${$scope.form_data.hp2}-${$scope.form_data.hp3}`;

    // 인증번호 전송
    window.fetch('/join/send_auth_num', {
      method: 'POST',
      headers: {
        "Content-Type": "application/json",
        [_csrf_header]: _csrf, // app.value 로 상위에서 주입된 값 (인증값)
      },
      body: JSON.stringify({
        to_phone: $scope.form_data.hp,
      }),
    }).then(response => response.json()).then(data => {
      // data = { AUTH_NUM: "", SEND_STATUS: true }
      $scope.form_data.can_auth = true;
      $scope.auth_num_send_status = data.SEND_STATUS;
      $scope.auth_end_time = moment(new Date()).add(120, 'seconds');

      if ($scope.auth_num_send_status) {
        $scope.timer_duration = $interval($scope.setAuthDuration, 1000);
        console.log("======> set timer");
      }
      $scope.auth_req_btn_txt = '인증번호 재요청';
    }).catch(err => {
      $scope.auth_num_send_status = false;
    });
  }

  /**
   * [Event] 인증하기 버튼 클릭
   */
  $scope.authNumConfirmSSG = function() {
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
      $scope.form_data.checkHpAuth.message = '인증번호를 넣으세요.';
      return;
    }

    // 확인 차, 다시 한번 Set
    $scope.form_data.hp = `${$scope.form_data.hp1}-${$scope.form_data.hp2}-${$scope.form_data.hp3}`;
    const phoneNumberNumberOnly = $scope.form_data.hp.replace(/[^\d]/g, '');
    const isSamePhone = savedPhoneNumberNoHyphen === phoneNumberNumberOnly;

    const params = {
      sale_no: $scope.sale.SALE_NO,
      hp: $scope.form_data.hp,
      done_cd: (isSamePhone ? 'no_modify' : 'un_modify'),
      auth_num: $scope.form_data.auth_num
    };

    apiPost('/join/confirm_auth_num4sale', params).then(data => {
      // 인증 실패 -> 종료
      if (typeof data.resultCode === 'undefined' || Number(data.resultCode) !== 0) {
        $scope.form_data.checkHpAuth.message = '인증에 실패 하였습니다. 다시 요청 하세요.';
        $scope.form_data.checkHpAuth.check = '';
        $scope.form_data.checkHpAuth.valid = data;
        return;
      }

      // 인증된 번호가 아닐 경우, 핸드폰을 변경
      if (!isSamePhone) {
        const confirms = window.confirm('고객정보의 핸드폰번호와 일치하지 않습니다.\n인증받은 핸드폰번호로 갱신하시겠습니까?');

        // 번호 갱신 안함 -> End
        if (!confirms) {
          $scope.form_data.checkHpAuth.message = '인증에 성공 하였습니다.';
          $scope.form_data.checkHpAuth.check = 'ok';
          $scope.parent.sale_cert.CNT = 1;
          $scope.close();
          return;
        }

        // 번호 갱신
        apiPost('/api/actionSet', {
          actionList: [
            {
              actionID: 'sale_cert_hp_mod',
              actionType: 'update',
              tableName: 'CERT',
              parmsList: [{ hp: $scope.form_data.hp, sale_cert_no: data.tables.CERT.rows[0].sale_cert_no }]
            }
          ]
        }).then(() => {
          $scope.form_data.checkHpAuth.message = '인증에 성공 하였습니다.';
          $scope.form_data.checkHpAuth.check = 'ok';
          $scope.parent.sale_cert.CNT = 1;
          $scope.close();
        });
      }
    }).then(() => {
      const params = {
        name: $scope.form_data.name,
        marketing_agree: $scope.form_data.checkAgreeMarketing ? 'Y' : 'N'
      }
      apiPost('/auth/update/info', params).then((res) => {
        $scope.form_data.checkHpAuth.message = '인증에 성공 하였습니다.';
        $scope.form_data.checkHpAuth.check = 'ok';
        $scope.parent.sale_cert.CNT = 1;
        $scope.close();
      });
    });
  }

  /**
   * [Event] 핸드폰 인증 메시지 변경
   */
  $scope.getHpAuthMsg = function() {
    return $scope.form_data.checkHpAuth.message;
  }

  /**
   * 타이머 구현 로직
   */
  $scope.setAuthDuration = function() {
    const format = 'm:s';
    const diffSeconds = moment($scope.auth_end_time).diff(moment(new Date()), 'seconds'); // 남은 초

    if (diffSeconds > 0) {
      $scope.form_data.checkHpAuth.message = "남은시간 : " + moment.duration(diffSeconds, "seconds").format(format);
    } else if (diffSeconds === 0) {
      $scope.form_data.can_auth = false;
      $scope.form_data.checkHpAuth.message = '0';
      $interval.cancel($scope.timer_duration);
      console.log('======> cancel timer');

      // 인증 만료 요청
      common.callAPI('/join/clear_auth_num', {}, function(){
        $scope.checkHpAuth.message = "인증 시간이 초과되었습니다. 다시 요청 하세요.";
      });
    }
  }

  /**
   * HTTP POST Request
   * @param {string} url 
   * @param {object} body 
   * @returns 
   */
  function apiPost(url, body) {
    return new Promise((resolve, reject) => {
      window.fetch(url, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          [_csrf_header]: _csrf, // app.value 로 상위에서 주입된 값 (인증값)
        },
        body: JSON.stringify(body),
      })
      .then(response => resolve(response.json()))
      .catch(err => reject(err));
    });
  }
});
